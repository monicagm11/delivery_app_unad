import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/category/category_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCrudScreen extends ConsumerStatefulWidget {
  const CategoryCrudScreen({super.key});

  @override
  ConsumerState<CategoryCrudScreen> createState() => _CategoryCrudScreenState();
}

class _CategoryCrudScreenState extends ConsumerState<CategoryCrudScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categoryNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryNotifierProvider);
    return CrudListTemplate(
      state: state,
      onCreate: (row) async {
        ref.read(categoryNotifierProvider.notifier).create(row);
      },
      onUpdate: (id, row) async {
        ref.read(categoryNotifierProvider.notifier).update(id, row);
      },
      crudConfig: CrudConfig(columns: Constants.headersCategory, formConfig: [
        FormFieldConfig(
            label: 'ID',
            id: 'id',
            enabled: false,
            type: FormFieldType.textInput,
            isRequired: false,
            updateEnable:(_) => false),
        FormFieldConfig(
            label: 'Nombre',
            id: 'name',
            enabled: true,
            type: FormFieldType.textInput,
            isRequired: true,
            updateEnable: (_) => true),
        FormFieldConfig(
            label: 'Descripción',
            id: 'description',
            enabled: true,
            type: FormFieldType.textInput,
            isRequired: true,
            updateEnable:(_) => true),
        FormFieldConfig(
          label: 'Estado',
          id: 'status',
          enabled: true,
          updateEnable:(_) => true,
          type: FormFieldType.list,
          isRequired: true,
          options: Constants.statusOptions,
        )
      ]),
    );
  }
}
