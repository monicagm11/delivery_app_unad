import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/manage_request/manage_request_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageRequestEventCrudScreen extends ConsumerStatefulWidget {
  const ManageRequestEventCrudScreen({super.key});

  @override
  ConsumerState<ManageRequestEventCrudScreen> createState() =>
      _ManageRequestEventCrudScreenState();
}

class _ManageRequestEventCrudScreenState extends ConsumerState<ManageRequestEventCrudScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(manageRequestEventNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(manageRequestEventNotifierProvider);
    return CrudListTemplate(
      state: state,
      onCreate: (row) async {
        //ref.read(manageRequestEventNotifierProvider.notifier).create(row);
      },
      onUpdate: (id, row) async {
        //ref.read(manageRequestEventNotifierProvider.notifier).update(id, row);
      },
      onOpenForm: (row) async {
        ref.read(manageRequestEventNotifierProvider.notifier).setProducts(row?? {});
      },
      crudConfig: CrudConfig(
          columns: Constants.headersCreateRequestEvents,
          name: 'Solicitud',
          showUpdateOption: false,
          formConfig: [
            FormFieldConfig(
              label: 'Comercio solicitante',
              id: 'commerceName',
              enabled: false,
              type: FormFieldType.textInput,
              isRequired: true,
              updateEnable: (_) => false),
          FormFieldConfig(
              label: 'Selecciona el evento',
              id: 'event',
              enabled: true,
              type: FormFieldType.eventSelector,
              isRequired: true,
              optionsData: state.globalEventOptions,
              updateEnable: (_) => false),
            FormFieldConfig(
              label: 'Localización de cliente',
              id: 'locationClientType',
              enabled: true,
              updateEnable: (_) => true,
              type: FormFieldType.list,
              isRequired: true,
              options: Constants.locationClientOptions,
              ),
            FormFieldConfig(
                label: 'Portafolio',
                id: 'products',
                enabled: true,
                type: FormFieldType.checkboxListSelector,
                isRequired: true,
                checkboxOptions: state.productOptions,
                updateEnable: (_) => false),
          ],
          additionalUpdateOptions: (row) {
            String currentStatus = row['status'];
            if (currentStatus == Constants.pendindStatus) {
              return [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red,),
                  onPressed: () async {
                    bool confirmation = await context.showConfirmationDialog('¿Estás seguro que desea rechazar esta solicitud?') ?? false;
                    if (!confirmation) return;
                    Map<String, dynamic> mapToUpdate = Map.from(row);
                    mapToUpdate['status'] =
                        Constants.rejectedStatus;
                    ref
                        .read(manageRequestEventNotifierProvider.notifier)
                        .updateFromTable(row['id'], mapToUpdate);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green,),
                  onPressed: () async {
                    bool confirmation = await context.showConfirmationDialog('¿Estás seguro que desea aceptar esta solicitud?') ?? false;
                    if (!confirmation) return;
                    Map<String, dynamic> mapToUpdate = Map.from(row);
                    mapToUpdate['status'] =
                        Constants.aprovedStatus;
                    ref
                        .read(manageRequestEventNotifierProvider.notifier)
                        .approveRequestFromTable(row['id'], mapToUpdate);
                  },
                ),
              ];
            }
            return [];
          },),
    );
  }
}
