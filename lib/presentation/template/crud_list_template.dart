import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';
import 'package:delivery_app/presentation/widgets/form_section.dart';
import 'package:flutter/material.dart';

class CrudListTemplate extends StatefulWidget {
  final CrudState state;
  final Future<void> Function(String id, Map<String, dynamic> row) onUpdate;
  final Future<void> Function(Map<String, dynamic> row) onCreate;
  final CrudConfig crudConfig;
  const CrudListTemplate(
      {super.key,
      required this.state,
      required this.crudConfig,
      required this.onUpdate,
      required this.onCreate});

  @override
  State<CrudListTemplate> createState() => _CrudListTemplateState();
}

class _CrudListTemplateState extends State<CrudListTemplate> {
  bool showForm = false;
  bool isFormUpdate= false;
  Map<String, dynamic>? rowSelected;
  @override
  Widget build(BuildContext context) {
    return _buildBody(widget.state);
  }

  Widget _buildBody(CrudState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text(state.errorMessage!));
    }

    /*if (state.items.isEmpty) {
      return const Center(child: Text('No items'));
    }*/

    return Row(
      children: [
        Expanded(
          flex: showForm ? 3 : 5,
          child: _buildTable(),
        ),
        if (showForm)
          Expanded(
            flex: 2,
            child: _buildForm(state),
          ),
      ],
    );
  }

  Widget _buildTable() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                rowSelected = null;
                isFormUpdate = false;
                showForm = true;
                
              });
            },
            child: const Text("Nuevo"),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              columns: [
                ...widget.crudConfig.columns.map(
                  (c) => DataColumn(label: Text(c.label, overflow: TextOverflow.ellipsis)),
                ),
                const DataColumn(label: Text("")),
              ],
              rows: widget.state.data.map((row) {
                return DataRow(
                  cells: [
                    ...widget.state.columns.map(
                      (c) => DataCell(
                        Text('${row[c.code] ?? '-'}', overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                rowSelected = row;
                                isFormUpdate = true;
                                showForm = true;
                              });
                            },
                          ),
                          IconButton(
                              icon: const Icon(Icons.block), onPressed: () {}
                              //widget.onDeactivate?.call(row),
                              ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(state) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: showForm
          ? Expanded(
              flex: 3,
              child: FormSection(
                  loading: state.isLoading,
                  fields: widget.crudConfig.formConfig,
                  title: isFormUpdate ? 'Actualizar ${rowSelected?['name'] ?? 'Comercio'}' : 'Crear Comercio',
                  isUpdate: isFormUpdate,
                  rowSelected: rowSelected,
                  onCreate:(row) async {
                    await widget.onCreate(row);
                    setState(() {
                      showForm = false;
                      rowSelected = null;
                    });
                  },
                  onUpdate:(id, row) async {
                    await widget.onUpdate(id, row);
                    setState(() {
                      showForm = false;
                      rowSelected = null;
                    });
                  },
                  onClose: () {
                    setState(() {
                      showForm = false;
                      rowSelected = null;
                    });
                  }
                  ),
            )
          : const SizedBox.shrink(),
    );
  }
}
