import 'dart:io';

import 'package:delivery_app/domain/entities/image_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerFormField extends FormField<ImageData> {
  ImagePickerFormField({
    super.key,
    super.onSaved,
    super.validator,
    this.isEnabled = true,
    super.initialValue,
    required this.label
  }) : super(
          builder: (state) => _ImagePickerField(
            state: state,
            isEnabled: isEnabled,
            label: label,
          ),
        );

  final bool isEnabled;
  final String label;
}

class _ImagePickerField extends StatefulWidget {
  final FormFieldState<ImageData> state;
  final bool isEnabled;
  final String label;

  const _ImagePickerField({
    required this.state,
    required this.isEnabled,
    required this.label
  });

  @override
  State<_ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<_ImagePickerField> {
  final _picker = ImagePicker();
  String? _localPath;
  Uint8List? _webBytes;
  late bool _hasImage;
  late final String folder;

  @override
  void initState() {
    super.initState();
    _hasImage = _webBytes != null ||
      _localPath != null ||
      (widget.state.value?.path != null && widget.state.value!.path!.isNotEmpty);
    folder = widget.state.value!.folder;
  }

  void _update() {
    if (_localPath == null) {
      widget.state.didChange(null);
      return;
    }
    widget.state.didChange(ImageData(
      path: _localPath!,
      bytes: _webBytes,
      folder: folder,
    ));
  }

  Future<void> _pick(ImageSource source) async {
    final file = await _picker.pickImage(source: source, imageQuality: 85);
    if (file == null) return;

    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      setState(() {
        _webBytes = bytes;
        _localPath = file.name;
      });
    } else {
      setState(() => _localPath = file.path);
    }
    _update();
  }

  void _remove() {
    setState(() {
      _localPath = null;
      _webBytes = null;
    });
    _update();
  }

  Widget _buildPreview() {
    String? initialImageUrl = widget.state.value?.path;
    if (kIsWeb && _webBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(_webBytes!, fit: BoxFit.cover),
      );
    }
    if (!kIsWeb && _localPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(File(_localPath!), fit: BoxFit.cover),
      );
    }
    if (initialImageUrl != null && initialImageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(initialImageUrl, fit: BoxFit.cover),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_photo_alternate_outlined,
            size: 48, color: Colors.grey.shade400),
        const SizedBox(height: 8),
        Text('Toca para seleccionar imagen',
            style: TextStyle(color: Colors.grey.shade500)),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: TextStyle(fontSize: 16)),
        SizedBox(height: 8,),
        GestureDetector(
          onTap: () => _showSourceSheet(context),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _buildPreview(),
          ),
        ),
        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              widget.state.errorText!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error, fontSize: 12),
            ),
          ),
        if (_hasImage)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _showSourceSheet(context),
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Cambiar'),
              ),
              TextButton.icon(
                onPressed: _remove,
                icon: const Icon(Icons.delete_outline, size: 16),
                label: const Text('Quitar'),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
            ],
          ),
      ],
    );
  }

  void _showSourceSheet(BuildContext context) {
    if (kIsWeb) {
      _pick(ImageSource.gallery);
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Galería'),
              onTap: () {
                Navigator.pop(context);
                _pick(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Cámara'),
              onTap: () {
                Navigator.pop(context);
                _pick(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
