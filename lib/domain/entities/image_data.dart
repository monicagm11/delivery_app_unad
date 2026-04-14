import 'dart:typed_data';

class ImageData {
  final String? path;
  final Uint8List? bytes; // solo en web
  final String folder;

  const ImageData({
    this.path,
    this.bytes,
    required this.folder,
  });
}
