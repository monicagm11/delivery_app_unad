import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:flutter/material.dart';

class DynamicFieldInput extends StatelessWidget {
  final FormFieldConfig formFieldConfig;
  final TextEditingController? controller;
  final String? Function(String?)? customValidator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final bool isEnabled;

  const DynamicFieldInput({
    super.key,
    required this.formFieldConfig,
    this.controller,
    this.customValidator,
    this.onChanged,
    this.onSaved,
    this.isEnabled = true
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: _getKeyboardType(),
      enabled: isEnabled,
      validator: (value) {
        final typeValidation = _validateByType(value);
        if (typeValidation != null) return typeValidation;

        if (customValidator != null) {
          return customValidator!(value);
        }

        return null;
      },
      decoration: InputDecoration(
        label: Text(formFieldConfig.label),
      ),
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }

  TextInputType _getKeyboardType() {
    switch (formFieldConfig.textDynamicInputType) {
      case TextDynamicInputType.email:
        return TextInputType.emailAddress;
      case TextDynamicInputType.phone:
        return TextInputType.phone;
      case TextDynamicInputType.text:
      default:
        return TextInputType.text;
    }
  }

  String? _validateByType(String? value) {
    if ((value == null || value.isEmpty) && formFieldConfig.isRequired) {
      return 'Campo requerido';
    }
    if (value == null || value.isEmpty) return null;

    switch (formFieldConfig.textDynamicInputType) {
      case TextDynamicInputType.email:
        final emailRegex = RegExp(
          r'^[^@]+@[^@]+\.[^@]+$',
        );
        if (!emailRegex.hasMatch(value)) {
          return 'Email inválido';
        }
        break;

      case TextDynamicInputType.phone:
        final phoneRegex = RegExp(r'^\d{7,15}$');
        if (!phoneRegex.hasMatch(value)) {
          return 'Teléfono inválido';
        }
        break;

      case TextDynamicInputType.text:
        break;
      case null:
        break;
    }

    return null;
  }
}