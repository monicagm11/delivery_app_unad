import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/user/user_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCrudScreen extends ConsumerStatefulWidget {
  const UserCrudScreen({super.key});

  @override
  ConsumerState<UserCrudScreen> createState() => _UserCrudScreenState();
}

class _UserCrudScreenState extends ConsumerState<UserCrudScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userNotifierProvider);
    return CrudListTemplate(
      state: state,
      onCreate: (row) async {
        ref.read(userNotifierProvider.notifier).create(row);
      },
      onUpdate: (id, row) async {
        ref.read(userNotifierProvider.notifier).update(id, row);
      },
      crudConfig: CrudConfig(
          columns: Constants.headersUsers,
          name: 'Usuario',
          formConfig: [
            FormFieldConfig(
            label: 'ID',
            id: 'id',
            enabled: false,
            type: FormFieldType.textInput,
            isRequired: true,
            updateEnable:(_) => false,),
        FormFieldConfig(
            label: 'Nombre',
            id: 'name',
            enabled: true,
            type: FormFieldType.textInput,
            isRequired: true,
            updateEnable:(_) => true),
        FormFieldConfig(
            label: 'Apellido',
            id: 'lastname',
            enabled: true,
            type: FormFieldType.textInput,
            isRequired: true,
            updateEnable:(_) => true),
        FormFieldConfig(
            label: 'Cargo',
            id: 'ocupation',
            enabled: true,
            type: FormFieldType.textInput,
            isRequired: true,
            updateEnable: (_) => true),
        FormFieldConfig(
          label: 'Rol',
          id: 'rol',
          enabled: true,
          updateEnable: (_) => true,
          type: FormFieldType.list,
          isRequired: true,
          options: state.rolOptions,
        ),
        FormFieldConfig(
            label: 'Identificación',
            id: 'identification',
            enabled: true,
            type: FormFieldType.identificationInput,
            isRequired: true,
            updateEnable:(_) => false),
        FormFieldConfig(
            label: '',
            id: 'cityDepartment',
            enabled: true,
            type: FormFieldType.departmentCitySelector,
            isRequired: true,
            updateEnable: (_) => true,
            optionsData: state.departmentOptions),
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
        )
      ]),
    );
  }
}
