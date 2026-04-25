import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';
import 'package:delivery_app/presentation/utils/action_form_type.dart';
import 'package:delivery_app/presentation/widgets/error_widget.dart';
import 'package:delivery_app/presentation/widgets/form_section.dart';
import 'package:flutter/material.dart';

class CrudListTemplate extends StatefulWidget {
  final CrudState state;
  final Future<void> Function(String id, Map<String, dynamic> row) onUpdate;
  final Future<void> Function(Map<String, dynamic> row) onCreate;
  final List<Category>? categories;
  final CrudConfig crudConfig;
  final Future<void> Function(Map<String, dynamic>? row)? onOpenForm;
  const CrudListTemplate(
      {super.key,
      required this.state,
      required this.crudConfig,
      required this.onUpdate,
      required this.onCreate,
      this.onOpenForm,
      this.categories});

  @override
  State<CrudListTemplate> createState() => _CrudListTemplateState();
}

class _CrudListTemplateState extends State<CrudListTemplate> {
  bool showForm = false;
  ActionFormType isFormUpdate = ActionFormType.create;
  Map<String, dynamic>? rowSelected;
  late final FunctionConfig functionConfig;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _filterStatus;
  String? _filterCategory;
  String? _filterCategoryName;
  bool isViewDetails = false;

  @override
  void initState() {
    super.initState();
    functionConfig = widget.state.functionConfig;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Valores únicos de status y category presentes en los datos
  Set<String> get _statusOptions => widget.state.data
      .map((r) => r['status']?.toString() ?? '')
      .where((v) => v.isNotEmpty)
      .toSet();

  Set<String> get _categoryOptions => widget.state.data
      .map((r) => r['category']?.toString() ?? '')
      .where((v) => v.isNotEmpty)
      .toSet();

  bool get _hasActiveFilters => _filterStatus != null || _filterCategory != null;

  List<Map<String, dynamic>> get _filteredData {
    return widget.state.data.where((row) {
      final matchName = _searchQuery.isEmpty ||
          (row['name'] ?? '').toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchStatus = _filterStatus == null || row['status'] == _filterStatus;
      final matchCategory = _filterCategory == null || row['category'] == _filterCategory;
      return matchName && matchStatus && matchCategory;
    }).toList();
  }

  void _clearFilters() => setState(() {
        _filterStatus = null;
        _filterCategory = null;
        _filterCategoryName = null;
      });

  void _showFilterSheet() {
    String? tempStatus = _filterStatus;
    String? tempCategory = _filterCategory;
    String? tempCategoryText = _filterCategoryName;
    final statusOptions = _statusOptions;
    final categoryOptions = _categoryOptions;
    final depuredCategories = widget.categories?.where((element) => categoryOptions.contains(element.id),).toSet() ?? {};

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Filtros',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        setSheetState(() {
                          tempStatus = null;
                          tempCategory = null;
                          tempCategoryText = null;
                        });
                      },
                      child: const Text('Limpiar'),
                    ),
                  ],
                ),
                const Divider(),

                // Filtro por estado
                if (statusOptions.isNotEmpty) ...[
                  const Text('Estado',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: statusOptions.map((s) {
                      final selected = tempStatus == s;
                      return FilterChip(
                        label: Text(s),
                        selected: selected,
                        onSelected: (_) => setSheetState(
                            () => tempStatus = selected ? null : s),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Filtro por categoría
                if (depuredCategories.isNotEmpty) ...[
                  const Text('Categoría',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: depuredCategories.map((c) {
                      final selected = tempCategory == c.id;
                      return FilterChip(
                        label: Text(c.name),
                        selected: selected,
                        onSelected: (_) => setSheetState(
                            () {
                              tempCategory = selected ? null : c.id;
                              tempCategoryText = selected ? null : c.name;
                            } ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _filterStatus = tempStatus;
                        _filterCategory = tempCategory;
                        _filterCategoryName = tempCategoryText;
                      });
                      Navigator.pop(ctx);
                    },
                    child: const Text('Aplicar'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildBody(widget.state);
  }

  Widget _buildBody(CrudState state) {
    final functionConfig = state.functionConfig;
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: ErrorIconWidget(errorMessage: state.errorMessage!,));
    }

    /*if (state.items.isEmpty) {
      return const Center(child: Text('No items'));
    }*/

    return Row(
      children: [
        Expanded(
          flex: showForm ? 3 : 5,
          child: functionConfig.readData ? _buildTable(functionConfig): ErrorIconWidget(errorMessage: 'No tienes los permisos para consultar esta información'),
        ),
        if (showForm)
          Expanded(
            flex: 2,
            child: _buildForm(state),
          ),
      ],
    );
  }

  Widget _buildTable(FunctionConfig functionConfig) {
    final data = _filteredData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: Row(
            children: [
              // Botón filtro
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    tooltip: 'Filtrar',
                    icon: const Icon(Icons.filter_list),
                    style: IconButton.styleFrom(
                      backgroundColor: _hasActiveFilters
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                    ),
                    onPressed: _showFilterSheet,
                  ),
                  if (_hasActiveFilters)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 4),
              // Buscador
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar por nombre...',
                    prefixIcon: const Icon(Icons.search),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                  ),
                  onChanged: (v) => setState(() => _searchQuery = v.trim()),
                ),
              ),
              const SizedBox(width: 8),
              if (functionConfig.createData)
              Row(
                children: [
                  ElevatedButton.icon(
                  onPressed: () async {
                    await widget.onOpenForm?.call(null);
                    setState(() {
                      rowSelected = null;
                      isFormUpdate = ActionFormType.create;
                      showForm = true;
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Nuevo'),
                ), 
                widget.crudConfig.additionalCreateOptions?.call() ?? SizedBox.shrink()
                ],
              ),
            ],
          ),
        ),
        // Chips de filtros activos
        if (_hasActiveFilters)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Wrap(
              spacing: 6,
              children: [
                if (_filterStatus != null)
                  Chip(
                    label: Text('Estado: $_filterStatus'),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    onDeleted: () => setState(() => _filterStatus = null),
                  ),
                if (_filterCategory != null)
                  Chip(
                    label: Text('Categoría: $_filterCategoryName'),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    onDeleted: () => setState(() => _filterCategory = null),
                  ),
                ActionChip(
                  label: const Text('Limpiar todo'),
                  onPressed: _clearFilters,
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${data.length} registro${data.length == 1 ? '' : 's'}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
              columns: [
                ...widget.crudConfig.columns.map(
                  (c) => DataColumn(label: Text(c.label, overflow: TextOverflow.ellipsis)),
                ),
                if (functionConfig.updateData) const DataColumn(label: Text("")),
              ],
              rows: data.map((row) {
                return DataRow(
                  cells: [
                    ...widget.state.columns.map(
                      (c) => DataCell(
                        Text('${row[c.code] ?? '-'}', overflow: TextOverflow.ellipsis),
                      ),
                    ),
                      DataCell(Row(children: [
                      (functionConfig.updateData && widget.crudConfig.showUpdateOption) ?
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await widget.onOpenForm?.call(row);
                            setState(() {
                              rowSelected = row;
                              isFormUpdate = ActionFormType.update;
                              showForm = true;
                            });
                          },
                        ) : IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () async {
                            await widget.onOpenForm?.call(row);
                            setState(() {
                              rowSelected = row;
                              isFormUpdate = ActionFormType.viewDetails;
                              showForm = true;
                            });
                          },
                        ),
                      if (functionConfig.updateData) ...widget.crudConfig.additionalUpdateOptions?.call(row) ?? []
                    ])),
                  ],
                );
              }).toList(),
            ),
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
                  title: isFormUpdate == ActionFormType.update
                      ? 'Actualizar ${rowSelected?['name'] ?? widget.crudConfig.name}'
                      : isFormUpdate == ActionFormType.create
                          ? 'Crear Comercio'
                          : 'Detalles ${rowSelected?['name'] ?? widget.crudConfig.name}',
                  isUpdate: isFormUpdate,
                  rowSelected: rowSelected,
                  onCreate: (row) async {
                    await widget.onCreate(row);
                      setState(() {
                        showForm = false;
                        rowSelected = null;
                      });
                  },
                  onUpdate: (id, row) async {
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
