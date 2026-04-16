import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/utils/constants.dart';

class CrudState {
  final bool isLoading;
  final String? errorMessage;
  final bool showForm;
  final List<TableColumnConfig> columns;
  final List<Map<String, dynamic>> data;
  final FunctionConfig functionConfig;

  const CrudState({
    required this.isLoading,
    this.errorMessage,
    required this.showForm,
    required this.columns,
    required this.data,
    required this.functionConfig
  });

  factory CrudState.initial(List<TableColumnConfig> columns) => CrudState(
        isLoading: false,
        errorMessage: null,
        showForm: false,
        columns: columns,
        data: [],
        functionConfig: Constants.defaultFunctionConfig
      );

  CrudState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data,
    FunctionConfig? functionConfig
  }) =>
      CrudState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data,
        functionConfig: functionConfig ?? this.functionConfig
      );
}
