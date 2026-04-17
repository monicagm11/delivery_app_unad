import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';

class GlobalEventState extends CrudState {
  List<Department> departmentOptions;
  GlobalEventState({
    required this.departmentOptions,
    required super.isLoading,
    super.errorMessage,
    required super.showForm,
    required super.columns,
    required super.data,
    required super.functionConfig
  });

  factory GlobalEventState.initial(List<TableColumnConfig> columns) => GlobalEventState(
        isLoading: false,
        errorMessage: null,
        showForm: false,
        columns: columns,
        data: [],
        departmentOptions: [],
        functionConfig: Constants.defaultFunctionConfig
      );

  @override
  GlobalEventState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data,
    List<Department>? departmentOptions,
    FunctionConfig? functionConfig,
    List<CheckboxOption>? productOptions
  }) =>
      GlobalEventState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data,
        departmentOptions: departmentOptions ?? this.departmentOptions,
        functionConfig: functionConfig ?? this.functionConfig
      );
}