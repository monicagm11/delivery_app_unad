import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:delivery_app/presentation/widgets/city_selector_field.dart';
import 'package:delivery_app/presentation/widgets/dynamic_dropdown.dart';
import 'package:delivery_app/presentation/widgets/dynamic_field_input.dart';
import 'package:delivery_app/presentation/widgets/identification_field.dart';
import 'package:flutter/material.dart';

class FormSection extends StatefulWidget {
  final VoidCallback onClose;
  final bool loading;
  final String? title;
  final List<FormFieldConfig> fields;
  final bool isUpdate;
  final Map<String, dynamic>? rowSelected;
  final Future<void> Function(String id, Map<String, dynamic> row) onUpdate;
  final Future<void> Function(Map<String, dynamic> row) onCreate;

  const FormSection(
      {super.key,
      required this.onClose,
      required this.loading,
      required this.fields,
      this.title,
      this.isUpdate = false,
      this.rowSelected,
      required this.onCreate,
      required this.onUpdate});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  late final Map<String, TextEditingController> controllers;
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  late Map<String, dynamic> formValues;
  late bool isUpdate;
  late Map<String, dynamic>? rowSelected;
  late final String? currentId;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isUpdate = widget.isUpdate;
    rowSelected = widget.rowSelected;
    currentId = rowSelected?['id'];
    controllers = Map.fromEntries(widget.fields
        .where((field) => (field.type == FormFieldType.textInput))
        .map((field) => MapEntry(field.id, TextEditingController(text: rowSelected?[field.id] ?? ''))));
    formValues = {};
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.title != null) Text(widget.title!),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: widget.onClose,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        spacing: 8,
                        children: [
                          ...widget.fields.map((field) {
                            return buildInnerWidget(field);
                          }),
                          ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState?.save();
                                  if (isUpdate) {
                                    await widget.onUpdate(currentId!, formValues);
                                  } else {
                                    await widget.onCreate(formValues);
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Text('GUARDAR'))
                        ],
                      )),
                )),
              ],
            ),
            AnimatedOpacity(
              opacity: isLoading ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: !widget.loading,
                child: Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInnerWidget(FormFieldConfig formFieldConfig) {
    switch (formFieldConfig.type) {
      case FormFieldType.textInput:
        return DynamicFieldInput(
          formFieldConfig: formFieldConfig,
          controller: controllers[formFieldConfig.id],
          isEnabled:
              isUpdate ? formFieldConfig.updateEnable : formFieldConfig.enabled,
          onChanged: (p0) {
            setState(() {
              isFormValid = formKey.currentState?.validate() ?? false;
            });
          },
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
        );
      case FormFieldType.list:
        return DynamicDropdown(
          formFieldConfig: formFieldConfig,
          initialValue: getDropdownInitialValue(formFieldConfig.id),
          isEnabled:
              isUpdate ? formFieldConfig.updateEnable : formFieldConfig.enabled,
          onChanged: (_, value) {
            setState(() {
              isFormValid = formKey.currentState?.validate() ?? false;
            });
          },
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
        );
      case FormFieldType.identificationInput:
        return IdentificationFormField(
          validator: (value) {
            if (value == null ||
                value.code.trim().isEmpty ||
                value.number.trim().isEmpty) {
              return 'Campo requerido';
            }
            return null;
          },
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
          initialValue: getIdInitialValue(),
          isEnabled:
              isUpdate ? formFieldConfig.updateEnable : formFieldConfig.enabled,
        );
      case FormFieldType.departmentCitySelector:
        return CitySelectorFormField(
          validator: (value) {
            if (value == null ||
                value.city.trim().isEmpty ||
                value.department.trim().isEmpty) {
              return 'Campo requerido';
            }
            return null;
          },
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
          initialValue: getCityInitialValue(),
          departments: formFieldConfig.optionsData as List<Department>,
          isEnabled:
              isUpdate ? formFieldConfig.updateEnable : formFieldConfig.enabled,
        );
    }
  }

  IdentificationData? getIdInitialValue() {
    final currentId = rowSelected?['document'];
    final currentIdType = rowSelected?['identificationType'];

    if (currentId != null && currentIdType != null) return IdentificationData(code: currentIdType, number: currentId);

    return null;
  }

  DropdownOption? getDropdownInitialValue(String id) {
    final currentValue = rowSelected?[id];

    if (currentValue != null) return DropdownOption(label: currentValue, value: currentValue);

    return null;
  }

  CityData? getCityInitialValue() {
    final currentDepartment = rowSelected?['department'];
    final currentCity = rowSelected?['city'];

    if (currentDepartment != null && currentCity != null) return CityData(department: currentDepartment, city: currentCity);

    return null;
  }
}
