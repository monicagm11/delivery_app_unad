import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:flutter/material.dart';

class CheckboxListFormField extends FormField<List<CheckboxOption>> {
  CheckboxListFormField({
    super.key,
    required List<CheckboxOption> options,
    List<CheckboxOption>? initialValue,
    super.onSaved,
    super.validator,
    bool isEnabled = true,
    String? label,
  }) : super(
          initialValue: initialValue ?? [],
          builder: (state) => _CheckboxListField(
            state: state,
            options: options,
            isEnabled: isEnabled,
            label: label,
          ),
        );
}

class _CheckboxListField extends StatefulWidget {
  final FormFieldState<List<CheckboxOption>> state;
  final List<CheckboxOption> options;
  final bool isEnabled;
  final String? label;

  const _CheckboxListField({
    required this.state,
    required this.options,
    required this.isEnabled,
    this.label,
  });

  @override
  State<_CheckboxListField> createState() => _CheckboxListFieldState();
}

class _CheckboxListFieldState extends State<_CheckboxListField> {
  late Set<CheckboxOption> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.state.value ?? []);
  }

  bool get _allSelected => _selected.length == widget.options.length;

  void _toggle(CheckboxOption value) {
    setState(() {
      _selected.contains(value) ? _selected.remove(value) : _selected.add(value);
    });
    widget.state.didChange(List.from(_selected));
  }

  void _toggleAll(bool? checked) {
    setState(() {
      _selected = checked == true ? Set.from(widget.options) : {};
    });
    widget.state.didChange(List.from(_selected));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(widget.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
          ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.state.hasError
                  ? Theme.of(context).colorScheme.error
                  : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Seleccionar todo
              CheckboxListTile(
                value: _allSelected,
                tristate: true,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Seleccionar todo',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                onChanged: widget.isEnabled ? _toggleAll : null,
              ),
              const Divider(height: 1),
              // Lista scrollable
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 160),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.options.length,
                  itemBuilder: (_, i) {
                    final option = widget.options[i];
                    return CheckboxListTile(
                      dense: true,
                      value: _selected.contains(option),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(option.label),
                      onChanged: widget.isEnabled
                          ? (v) => _toggle(option)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Text(
              widget.state.errorText!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
