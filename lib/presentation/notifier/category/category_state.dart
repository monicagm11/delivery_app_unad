import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';

class CategoryState extends CrudState {
  CategoryState(
      {required super.isLoading,
      required super.showForm,
      required super.columns,
      required super.data,
      super.errorMessage,
      required super.functionConfig});

  factory CategoryState.initial(List<TableColumnConfig> columns) =>
      CategoryState(
          isLoading: false,
          errorMessage: null,
          showForm: false,
          columns: columns,
          data: [],
          functionConfig: Constants.defaultFunctionConfig,
          );

  @override
  CategoryState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data,
    FunctionConfig? functionConfig
  }) =>
      CategoryState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data,
        functionConfig: functionConfig ?? this.functionConfig
      );
}
