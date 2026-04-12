import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:flutter/material.dart';

class DynamicDropdown extends StatelessWidget {
  final FormFieldConfig formFieldConfig;
  final DropdownOption? initialValue;
  final Function(String, String?) onChanged;
  final Function(String?) onSaved;
  final bool isEnabled;
  const DynamicDropdown({super.key, required this.formFieldConfig, required this.initialValue, required this.onChanged, required this.onSaved, this.isEnabled = true});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        value: initialValue?.value,
        decoration: InputDecoration(labelText: formFieldConfig.label),
        items: formFieldConfig.options!
            .map((opt) => DropdownMenuItem(
                  value: opt.value,
                  child: Text(opt.label),
                ))
            .toList(),
        onChanged: (value) {
          onChanged(formFieldConfig.id, value);
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Campo requerido';
          return null;
        },
        onSaved: onSaved,
      );
  }
  
}