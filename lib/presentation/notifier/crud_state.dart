import 'package:delivery_app/domain/entities/table_column_config.dart';

class CrudState {
  final bool isLoading;
  final String? errorMessage;
  final bool showForm;
  final List<TableColumnConfig> columns;
  final List<Map<String, dynamic>> data;

  const CrudState({
    required this.isLoading,
    this.errorMessage,
    required this.showForm,
    required this.columns,
    required this.data
  });

  factory CrudState.initial(List<TableColumnConfig> columns) => CrudState(
        isLoading: false,
        errorMessage: null,
        showForm: false,
        columns: columns,
        data: []
      );

  CrudState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data
  }) =>
      CrudState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data
      );
}
