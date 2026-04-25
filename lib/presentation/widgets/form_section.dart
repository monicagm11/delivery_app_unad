import 'package:delivery_app/domain/entities/calculator_price_data.dart';
import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/date_data.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:delivery_app/domain/entities/image_data.dart';
import 'package:delivery_app/domain/entities/rol_data.dart';
import 'package:delivery_app/presentation/forms/event_request_form.dart';
import 'package:delivery_app/presentation/utils/action_form_type.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/widgets/checkbox_list_field.dart';
import 'package:delivery_app/presentation/widgets/city_selector_field.dart';
import 'package:delivery_app/presentation/widgets/date_picker_field.dart';
import 'package:delivery_app/presentation/widgets/dynamic_dropdown.dart';
import 'package:delivery_app/presentation/widgets/dynamic_field_input.dart';
import 'package:delivery_app/presentation/widgets/identification_field.dart';
import 'package:delivery_app/presentation/widgets/image_picker_field.dart';
import 'package:delivery_app/presentation/widgets/map_location_field.dart';
import 'package:delivery_app/presentation/widgets/price_calculator_field.dart';
import 'package:delivery_app/presentation/widgets/rol_selector_field.dart';
import 'package:flutter/material.dart';

class FormSection extends StatefulWidget {
  final VoidCallback onClose;
  final bool loading;
  final String? title;
  final List<FormFieldConfig> fields;
  final ActionFormType isUpdate;
  final Map<String, dynamic>? rowSelected;
  final Future<void> Function(String id, Map<String, dynamic> row) onUpdate;
  final Future<void> Function(Map<String, dynamic> row) onCreate;

  const FormSection(
      {super.key,
      required this.onClose,
      required this.loading,
      required this.fields,
      this.title,
      this.isUpdate = ActionFormType.create,
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
  late ActionFormType isUpdate;
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
        .map((field) => MapEntry(field.id,
            TextEditingController(text: rowSelected?[field.id] ?? ''))));
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
                          if (isUpdate != ActionFormType.viewDetails) ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                    if (isUpdate == ActionFormType.update) {
                                      bool confirmation =
                                          await showConfirmationDialog(context,
                                                  '¿Está seguro que desea actualizar el registro?') ??
                                              false;
                                      if (confirmation) {
                                        await widget.onUpdate(
                                            currentId!, formValues);
                                      }
                                    } else if (isUpdate ==
                                        ActionFormType.create) {
                                      bool confirmation =
                                          await showConfirmationDialog(context,
                                                  '¿Está seguro que desea almacenar estos datos?') ??
                                              false;
                                      if (confirmation) {
                                        await widget.onCreate(formValues);
                                      }
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
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
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
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
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
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
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
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
        );
      case FormFieldType.imagePicker:
        return ImagePickerFormField(
          initialValue: getImageInitialValue(formFieldConfig.folder!, formFieldConfig.id),
          label: formFieldConfig.label,
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
          validator: (value) {
            if ((value?.path == null) &&
                formFieldConfig.isRequired) {
              return 'Campo requerido';
            }
            return null;
          },
          isEnabled:
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
        );
      case FormFieldType.datePicker:
        return DatePickerField(
          formFieldConfig: formFieldConfig,
          isEnabled:
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
          initialValue: getDateInitialValue(formFieldConfig.id),
        );
      case FormFieldType.priceCalculator:
        return PriceCalculatorFormField(
          initialValue: CalculatorPriceData(
              priceBase: rowSelected?['priceBase'] ?? 0,
              ivaPercentage: rowSelected?['percentageIva'] ?? 0,
              ivaValue: rowSelected?['valueIva'] ?? 0,
              priceTotal: rowSelected?['totalPrice'] ?? 0),
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
          isEnabled:
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
        );
      case FormFieldType.mapSelector:
        return MapLocationFormField(
          initialValue: getMapInitialValue(),
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          }
        );
      case FormFieldType.checkboxListSelector:
        return CheckboxListFormField(
          options: formFieldConfig.checkboxOptions!,
          label: formFieldConfig.label,
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
          isEnabled:
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
          validator: (value) {
            if ((value == null || value.isEmpty) &&
                formFieldConfig.isRequired) {
              return 'Campo requerido';
            }
            return null;
          },
          initialValue: getOptionsChecked(formFieldConfig),
        );
      case FormFieldType.eventSelector:
        return EventRequestFormField(
            options: formFieldConfig.optionsData as List<GlobalEvent>,
            onSaved: (value) {
              formValues[formFieldConfig.id] = value;
            },
            isEnabled:
              (isUpdate == ActionFormType.update) ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false) : (isUpdate == ActionFormType.create)? formFieldConfig.enabled : false,
            initialValue: getEventInitialValue(formFieldConfig),
            validator: (value) {
              if ((value == null) && formFieldConfig.isRequired) {
                return 'Campo requerido';
              }
              return null;
            });
      case FormFieldType.rolSelector:
        return RolSelectorFormField(
          roles: formFieldConfig.options as List<DropdownOption>,
          commerceOptions: formFieldConfig.optionsData  as List<DropdownOption>,
          onSaved: (value) {
            formValues[formFieldConfig.id] = value;
          },
          initialValue: getRolInitialValue(),
          isEnabled: (isUpdate == ActionFormType.update)
              ? (formFieldConfig.updateEnable?.call(rowSelected!) ?? false)
              : (isUpdate == ActionFormType.create)
                  ? formFieldConfig.enabled
                  : false,
          validator: (value) {
              if ((value == null || value.rol.trim().isEmpty || (value.rol == Constants.adminRolCode && value.commerce == null)) && formFieldConfig.isRequired) {
                return 'Campo requerido';
              }
              return null;
            }
        );
    }
  }

  IdentificationData? getIdInitialValue() {
    final currentId = rowSelected?['document'];
    final currentIdType = rowSelected?['identificationType'];

    if (currentId != null && currentIdType != null) {
      return IdentificationData(code: currentIdType, number: currentId);
    }

    return null;
  }

  DropdownOption? getDropdownInitialValue(String id) {
    final currentValue = rowSelected?[id];

    if (currentValue != null) {
      return DropdownOption(label: currentValue, value: currentValue);
    }

    return null;
  }

  CityData? getCityInitialValue() {
    final currentDepartment = rowSelected?['department'];
    final currentCity = rowSelected?['city'];

    if (currentDepartment != null && currentCity != null) {
      return CityData(department: currentDepartment, city: currentCity);
    }

    return null;
  }

  ImageData? getImageInitialValue(String folder, String id) {
    final currentImage = rowSelected?[id];
    return ImageData(path: currentImage, folder: folder);
  }

  MapLocationData getMapInitialValue() {
    return MapLocationData(latitude: rowSelected?['latitude'] ?? 0, longitude: rowSelected?['longitude'] ?? 0, radious: rowSelected?['radious'] ?? 0);
  }

  DateData? getDateInitialValue(String key) {
    final currentDate = rowSelected?[key] as String?;
    if (currentDate != null && currentDate.trim().isNotEmpty && currentDate.contains(':')) {
      final dateData = currentDate.split(' ');
      return DateData(date: dateData[0], hour: dateData[1], fullDate: currentDate);
    }
    return null;
  }

  List<CheckboxOption> getOptionsChecked(FormFieldConfig formFieldConfig) {
    final options = rowSelected? [formFieldConfig.id];
    if(options!= null && options is List<String>) {
      return formFieldConfig.checkboxOptions!.where((e) => options.contains(e.value)).toList();
    }
    return [];
  }

  GlobalEvent? getEventInitialValue(FormFieldConfig formFieldConfig) {
    final options = formFieldConfig.optionsData;
    final optionSelected = rowSelected? ['eventId'];
    if(options != null && options is List<GlobalEvent> ) {
      return options.cast<GlobalEvent>().where((e) => e.id == optionSelected).firstOrNull;
    }
    return null;
  }

  RolData? getRolInitialValue() {
    final currentRol = rowSelected?['rol'];
    final currentCommerce = rowSelected?['commerce'];
    return RolData(rol: currentRol, commerce: currentCommerce);
  }

    Future<bool?> showConfirmationDialog(BuildContext context, String message) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirmación'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
}
