import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/presentation/notifier/manage_sales/manage_sales_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/utils/context_extensions.dart';
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
            updateEnable:(_) => false),
        FormFieldConfig(
                label: 'Productos',
                id: 'products',
                enabled: false,
                type: FormFieldType.tableField,
                isRequired: false,
                updateEnable: (_) => false,
                columns: Constants.headersSaleItems,
                dataId: 'checkoutItems')
      ],
      additionalUpdateOptions: (row) {
        String currentStatus = row['status'];
        
        if (currentStatus != Constants.orderDoneStatus && currentStatus != Constants.orderCanceledStatus) {
          String nextStatus = getNextStatus(currentStatus);
          return [
            IconButton(
                    icon: getIcon(currentStatus),
                    tooltip: getNextStatusTooltip(currentStatus),
                    onPressed: () async {
                      if (nextStatus == Constants.orderAssignededStatus) {
                        ref.read(manageSalesRealtimeProvider.notifier).setLogisticAvailable(row['eventId']);

                        User? deliveryAssignedId = await context.showLogisticsSelectorDialog(users: state.logisticAvailable);
                        if (deliveryAssignedId != null) {
                          ref.read(manageSalesRealtimeProvider.notifier).setDeliveryToOrder(row['id'], deliveryAssignedId.id, nextStatus);
                        }
                      } else {
                        bool confirmation = await context.showConfirmationDialog('¿Estás seguro que desea actualizar el estado a $nextStatus?') ?? false;
                        if (confirmation) {
                          ref.read(manageSalesRealtimeProvider.notifier).updateStatusOrder(row['id'], nextStatus);
                        }
                      }
                    },
                  ),
                  IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red,),
                  onPressed: () async {
                    bool confirmation = await context.showConfirmationDialog('¿Estás seguro que desea cancelar este pedido?') ?? false;
                        if (confirmation) {
                          ref.read(manageSalesRealtimeProvider.notifier).updateStatusOrder(row['id'], Constants.orderCanceledStatus);
                        }
                  },
                )];
        }
        return [];
      }
      ),
      
    );
  }

  Icon getIcon (String currentStatus) {
    switch(currentStatus) {
      case Constants.orderCreatedStatus:
        return Icon(Icons.check_box, color: Colors.yellow);
      case Constants.orderConfirmedStatus:
        return Icon(Icons.person_add_outlined, color: Colors.lightBlueAccent);
      case Constants.orderAssignededStatus:
        return Icon(Icons.delivery_dining, color: Colors.blue);
      default:
        return Icon(Icons.close, color: Colors.red,);
    }
  }

  String getNextStatus (String currentStatus) {
    switch(currentStatus) {
      case Constants.orderCreatedStatus:
        return Constants.orderConfirmedStatus;
      case Constants.orderConfirmedStatus:
        return Constants.orderAssignededStatus;
      case Constants.orderAssignededStatus:
        return Constants.orderSendedStatus;
      default:
        return '';
    }
  }

  String getNextStatusTooltip (String currentStatus) {
    switch(currentStatus) {
      case Constants.orderCreatedStatus:
        return 'Confirmar';
      case Constants.orderConfirmedStatus:
        return 'Asignar a personal';
      case Constants.orderAssignededStatus:
        return 'Marcar como enviado';
      default:
        return '';
    }
  }
  }