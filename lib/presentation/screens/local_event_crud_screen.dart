import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:delivery_app/presentation/notifier/local_event/local_event_notifier.dart';
import 'package:delivery_app/presentation/screens/create_request_screen.dart';
import 'package:delivery_app/presentation/template/crud_list_template.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalEventCrudScreen extends ConsumerStatefulWidget {
  const LocalEventCrudScreen({super.key});

  @override
  ConsumerState<LocalEventCrudScreen> createState() =>
      _LocalEventCrudScreenState();
}

class _LocalEventCrudScreenState extends ConsumerState<LocalEventCrudScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(localEventNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(localEventNotifierProvider);
    return CrudListTemplate(
      state: state,
      onCreate: (row) async {
        ref.read(localEventNotifierProvider.notifier).create(row);
      },
      onUpdate: (id, row) async {
        ref.read(localEventNotifierProvider.notifier).update(id, row);
      },
      crudConfig: CrudConfig(
        name: 'Evento',
        columns: Constants.headersEvents,
        formConfig: [
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
                label: 'Descripción',
                id: 'description',
                enabled: true,
                type: FormFieldType.textInput,
                isRequired: true,
                updateEnable: (_) => true),
            FormFieldConfig(
                label: '',
                id: 'cityDepartment',
                enabled: true,
                type: FormFieldType.departmentCitySelector,
                isRequired: true,
                updateEnable: (_) => true,
                optionsData: state.departmentOptions),
            FormFieldConfig(
                label: '',
                id: 'location',
                enabled: true,
                type: FormFieldType.mapSelector,
                isRequired: true,
                updateEnable: (_) => true),
            FormFieldConfig(
                label: 'Fecha programada',
                id: 'scheduleDate',
                enabled: true,
                type: FormFieldType.datePicker,
                isRequired: true,
                updateEnable: (_) => true),
            FormFieldConfig(
                label: 'Fecha inicio',
                id: 'startDate',
                enabled: false,
                type: FormFieldType.datePicker,
                isRequired: false,
                updateEnable: (_) => false),
            FormFieldConfig(
                label: 'Fecha fin',
                id: 'endDate',
                enabled: false,
                type: FormFieldType.datePicker,
                isRequired: false,
                updateEnable: (_) => false),
            FormFieldConfig(
                label: 'Portafolio',
                id: 'products',
                enabled: true,
                type: FormFieldType.checkboxListSelector,
                isRequired: true,
                checkboxOptions: state.productOptions,
                updateEnable: (_) => true),
          ],
          additionalUpdateOptions: (row) {
            String currentStatus = row['status'];
            if (currentStatus != Constants.canceledStatus &&
                currentStatus != Constants.endedStatus) {
              return [
                IconButton(
                  icon: Icon(currentStatus == Constants.programmedStatus
                      ? Icons.play_arrow
                      : Icons.stop),
                  onPressed: () {
                    Map<String, dynamic> mapToUpdate = Map.from(row);
                    mapToUpdate['status'] =
                        currentStatus == Constants.programmedStatus
                            ? Constants.startedStatus
                            : Constants.endedStatus;
                    ref
                        .read(localEventNotifierProvider.notifier)
                        .updateFromTable(row['id'], mapToUpdate);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    Map<String, dynamic> mapToUpdate = Map.from(row);
                    mapToUpdate['status'] = Constants.canceledStatus;
                    ref
                        .read(localEventNotifierProvider.notifier)
                        .updateFromTable(row['id'], mapToUpdate);
                  },
                )
              ];
            }
            return [];
          },
          additionalCreateOptions: () {
            return ElevatedButton.icon(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    insetPadding: const EdgeInsets.all(24),
                    child: SizedBox(
                      width: 800,
                      height: 600,
                      child: CreateRequestEventCrudScreen(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add_task_sharp),
              label: const Text('Solicitar'),
            )
            ;
          },),
    );
  }
}
