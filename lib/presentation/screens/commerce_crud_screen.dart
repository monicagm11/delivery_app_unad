import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/commerce_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceCrudScreen extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> data = [
    {
      "id": "1",
      "name": "Pizzeria MyG",
      "status": "ACTIVO",
      'fullDocument': 'NIT 123456',
      'identificationType': 'NIT',
      'document': '123456',
      'phone': '3001234567',
      'address': 'CL 1 2-3',
      'email': 'ejemplo@gmail.com',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'contactName': 'Samanta Collazos'
    },
    {
      "id": "2",
      "name": "Hamburguesas Alameda",
      "status": "INACTIVO",
      'fullDocument': 'CC 12309',
      'identificationType': 'CC',
      'document': '12309',
      'phone': '3019995522',
      'address': 'KR 9 8-7',
      'email': 'ejemplo2@gmail.com',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'contactName': 'Carlos Puello'
    },
  ];
  CommerceCrudScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: CrudListTemplate(
        state: state,
        onCreate: (row) async {
           ref.read(commerceNotifierProvider.notifier).create(row);
        },
        onUpdate: (id, row) async {
          ref.read(commerceNotifierProvider.notifier).update(id, row);
        },
        crudConfig: CrudConfig(columns: Constants.headersCommerce, formConfig: [
          FormFieldConfig(
              label: 'ID',
              id: 'id',
              enabled: false,
              type: FormFieldType.textInput,
              isRequired: true,
              updateEnable: false),
          FormFieldConfig(
              label: 'Nombre',
              id: 'name',
              enabled: true,
              type: FormFieldType.textInput,
              isRequired: true,
              updateEnable: true),
          FormFieldConfig(
              label: 'Identificación',
              id: 'identification',
              enabled: true,
              type: FormFieldType.identificationInput,
              isRequired: true,
              updateEnable: false),
          FormFieldConfig(
              label: '',
              id: 'cityDepartment',
              enabled: true,
              type: FormFieldType.departmentCitySelector,
              isRequired: true,
              updateEnable: true,
              optionsData: state.departmentOptions),
          /*FormFieldConfig(
              label: 'Departamento',
              id: 'department',
              enabled: true,
              type: FormFieldType.list,
              isRequired: true,
              updateEnable: true,
              options: [
                DropdownOption(label: 'Atlantico', value: 'ATLANTICO')
              ]),
          FormFieldConfig(
              label: 'Ciudad',
              id: 'city',
              enabled: true,
              type: FormFieldType.list,
              isRequired: true,
              updateEnable: true,
              options: [
                DropdownOption(label: 'Barranquilla', value: 'BARRANQUILLA')
              ]),*/
          FormFieldConfig(
              label: 'Contacto',
              id: 'contactName',
              enabled: true,
              type: FormFieldType.textInput,
              isRequired: true,
              updateEnable: true),
          FormFieldConfig(
              label: 'Teléfono',
              id: 'phone',
              enabled: true,
              updateEnable: true,
              type: FormFieldType.textInput,
              textDynamicInputType: TextDynamicInputType.phone,
              isRequired: true),
          FormFieldConfig(
              label: 'Dirección',
              id: 'address',
              enabled: true,
              updateEnable: true,
              type: FormFieldType.textInput,
              isRequired: true),
          FormFieldConfig(
              label: 'Email',
              id: 'email',
              enabled: true,
              updateEnable: true,
              type: FormFieldType.textInput,
              isRequired: true,
              textDynamicInputType: TextDynamicInputType.email),
          FormFieldConfig(
              label: 'Estado',
              id: 'status',
              enabled: true,
              updateEnable: true,
              type: FormFieldType.list,
              isRequired: true,
              options: [
                DropdownOption(label: 'Activo', value: 'ACTIVO'),
                DropdownOption(label: 'Inactivo', value: 'INACTIVO')
              ])
        ]),
      ),
    );
  }
}
