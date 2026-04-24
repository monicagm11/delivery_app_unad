import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/product/product_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCrudScreen extends ConsumerStatefulWidget {
  const ProductCrudScreen({super.key});

  @override
  ConsumerState<ProductCrudScreen> createState() => _ProductCrudScreenState();
}

class _ProductCrudScreenState extends ConsumerState<ProductCrudScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(productNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productNotifierProvider);
    return CrudListTemplate(
        state: state,
        onCreate: (row) async {
           ref.read(productNotifierProvider.notifier).create(row);
        },
        onUpdate: (id, row) async {
          ref.read(productNotifierProvider.notifier).update(id, row);
        },
        categories: state.categories,
        crudConfig: CrudConfig(columns: state.columns, 
        name: 'Producto',
        formConfig: [
          FormFieldConfig(
              label: 'Imagen del producto',
              id: 'image',
              enabled: true,
              type: FormFieldType.imagePicker,
              isRequired: false,
              folder: Constants.productsFolder,
              updateEnable:(_) => true),
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
              updateEnable: (_) => true),
          FormFieldConfig(
              label: '',
              id: 'price',
              enabled: true,
              type: FormFieldType.priceCalculator,
              isRequired: true,
              updateEnable: (_) => true),
          FormFieldConfig(
              label: 'Categoría',
              id: 'category',
              enabled: true,
              updateEnable: (_) => true,
              type: FormFieldType.list,
              isRequired: true,
              options: state.categoryOptions,
              ),
          FormFieldConfig(
              label: 'Estado',
              id: 'status',
              enabled: true,
              updateEnable: (_) => true,
              type: FormFieldType.list,
              isRequired: true,
              options: Constants.statusOptions,
              ),
        ]),
      );
  }
}
