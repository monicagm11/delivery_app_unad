import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/manage_sales/manage_sales_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageSalesCrudScreen  extends ConsumerStatefulWidget {
  const ManageSalesCrudScreen({super.key});

  @override
  ConsumerState<ManageSalesCrudScreen> createState() => _ManageSalesCrudScreenState();
}

class _ManageSalesCrudScreenState extends ConsumerState<ManageSalesCrudScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
    ref.read(manageSalesRealtimeProvider.notifier).watchCollection()
  );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(manageSalesRealtimeProvider);
    return CrudListTemplate(
      state: state,
      onCreate: (row) async {
        //ref.read(categoryNotifierProvider.notifier).create(row);
      },
      onUpdate: (id, row) async {
        //ref.read(categoryNotifierProvider.notifier).update(id, row);
      },
      crudConfig: CrudConfig(columns: Constants.headersSales, 
      name: 'Venta', formConfig: [
        FormFieldConfig(
            label: 'ID',
            id: 'id',
            enabled: false,
            type: FormFieldType.textInput,
            isRequired: false,
            updateEnable:(_) => false),
        FormFieldConfig(
            label: 'Método de pago',
            id: 'paymentMethodName',
            enabled: false,
            type: FormFieldType.textInput,
            isRequired: false,
            updateEnable:(_) => false),
        FormFieldConfig(
            label: 'Total',
            id: 'total',
            enabled: false,
            type: FormFieldType.textInput,
            isRequired: false,
            updateEnable:(_) => false)
      ]),
    );

  }
  }