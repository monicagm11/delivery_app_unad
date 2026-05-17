import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/create_request/create_request_notifier.dart';
import 'package:delivery_app/presentation/notifier/local_event/local_event_notifier.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRequestEventCrudScreen extends ConsumerStatefulWidget {
  const CreateRequestEventCrudScreen({super.key});

  @override
  ConsumerState<CreateRequestEventCrudScreen> createState() =>
      _CreateRequestEventCrudScreenState();
}

class _CreateRequestEventCrudScreenState extends ConsumerState<CreateRequestEventCrudScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(createRequestEventNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createRequestEventNotifierProvider);
    return CrudListTemplate(
      state: state,
      
      onCreate: (row) async {
        ref.read(createRequestEventNotifierProvider.notifier).create(row);
      },
      onUpdate: (id, row) async {
        ref.read(createRequestEventNotifierProvider.notifier).update(id, row);
      },
      crudConfig: CrudConfig(
          columns: Constants.headersCreateRequestEvents,
          name: 'Solicitud',
          showUpdateOption: false,
          formConfig: [
            FormFieldConfig(
                label: 'Selecciona el evento',
                id: 'event',
                enabled: true,
                type: FormFieldType.eventSelector,
                isRequired: true,
                optionsData: state.globalEventAvailableOptions,
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
                updateEnable: (row) => row['status'] == Constants.pendindStatus)
          ],
          additionalUpdateOptions: (row) {
            String currentStatus = row['status'];
            if (currentStatus == Constants.pendindStatus) {
              return [
                IconButton(
                  icon: Icon(Icons.cancel, color: Colors.red,),
                  onPressed: () async {
                    bool confirmation = await context.showConfirmationDialog('¿Estás seguro que desea cancelar esta solicitud?') ?? false;
                    if (!confirmation) return;
                    Map<String, dynamic> mapToUpdate = Map.from(row);
                    mapToUpdate['status'] =
                        Constants.canceledStatus;
                    ref
                        .read(createRequestEventNotifierProvider.notifier)
                        .updateFromTable(row['id'], mapToUpdate);
                  },
                ),
              ];
            }
            return [];
          },),
    );
  }
}
