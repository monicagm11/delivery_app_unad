import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';

class FormFieldConfig {
  final String label;
  final String id;
  final bool enabled;
  final bool Function(Map<String, dynamic>)? updateEnable;
  final FormFieldType type;
  final bool isRequired;
  final TextDynamicInputType? textDynamicInputType;
  final List<DropdownOption>? options;
  final List<CheckboxOption>? checkboxOptions;
  final List<dynamic>? optionsData;
  final String? folder;

  const FormFieldConfig({
    required this.label,
    required this.id,
    required this.enabled,
    required this.type,
    required this.isRequired,
    required this.updateEnable,
    this.textDynamicInputType,
    this.options,
    this.optionsData,
    this.folder,
    this.checkboxOptions
  });
}
