import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/commerce/commerce_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceCrudScreen extends ConsumerStatefulWidget {
  const CommerceCrudScreen({super.key});

  @override
  ConsumerState<CommerceCrudScreen> createState() => _CommerceCrudScreenState();
}

class _CommerceCrudScreenState extends ConsumerState<CommerceCrudScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(commerceNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commerceNotifierProvider);
    return CrudListTemplate(
      state: state,
      onCreate: (row) async {
        ref.read(commerceNotifierProvider.notifier).create(row);
      },
      onUpdate: (id, row) async {
        ref.read(commerceNotifierProvider.notifier).update(id, row);
      },
      crudConfig: CrudConfig(columns: Constants.headersCommerce,
      name: 'Comercio', 
      formConfig: [
        FormFieldConfig(
                label: 'Logo/Imagen del comercio',
                id: 'urlImage',
                enabled: true,
                type: FormFieldType.imagePicker,
                isRequired: true,
                folder: Constants.commerceFolder,
                updateEnable: (_) => true),
            FormFieldConfig(
                label: 'ID',
                id: 'id',
                enabled: false,
                type: FormFieldType.textInput,
                isRequired: false,
                updateEnable: (_) => false),
            FormFieldConfig(
                label: 'Nombre',
                id: 'name',
                enabled: true,
                type: FormFieldType.textInput,
                isRequired: true,
                updateEnable: (_) => true),
            FormFieldConfig(
                label: 'Identificación',
                id: 'identification',
                enabled: true,
                type: FormFieldType.identificationInput,
                isRequired: true,
                updateEnable: (_) => false),
            FormFieldConfig(
                label: '',
                id: 'cityDepartment',
                enabled: true,
                type: FormFieldType.departmentCitySelector,
                isRequired: true,
                updateEnable: (_) => true,
                optionsData: state.departmentOptions),
            FormFieldConfig(
                label: 'Contacto',
                id: 'contactName',
                enabled: true,
                type: FormFieldType.textInput,
                isRequired: true,
                updateEnable: (_) => true),
            FormFieldConfig(
                label: 'Teléfono',
                id: 'phone',
                enabled: true,
                updateEnable: (_) => true,
                type: FormFieldType.textInput,
                textDynamicInputType: TextDynamicInputType.phone,
                isRequired: true),
            FormFieldConfig(
                label: 'Dirección',
                id: 'address',
                enabled: true,
                updateEnable: (_) => true,
                type: FormFieldType.textInput,
                isRequired: true),
            FormFieldConfig(
                label: 'Email',
                id: 'email',
                enabled: true,
                updateEnable: (_) => true,
                type: FormFieldType.textInput,
                isRequired: true,
                textDynamicInputType: TextDynamicInputType.email),
            FormFieldConfig(
              label: 'Estado',
              id: 'status',
              enabled: true,
              updateEnable: (_) => true,
              type: FormFieldType.list,
              isRequired: true,
              options: Constants.statusOptions,
            ),
            FormFieldConfig(
                label: 'Seleccione un QR para pagos',
                id: 'urlImageQR',
                enabled: true,
                type: FormFieldType.imagePicker,
                isRequired: true,
                folder: Constants.qrFolder,
                updateEnable: (_) => true),
      ]),
    );
  }
}
