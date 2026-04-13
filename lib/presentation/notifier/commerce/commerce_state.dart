import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';

class CommerceState extends CrudState {
  List<Department> departmentOptions;
  CommerceState({
    required this.departmentOptions,
    required super.isLoading,
    super.errorMessage,
    required super.showForm,
    required super.columns,
    required super.data
  });

  factory CommerceState.initial(List<TableColumnConfig> columns) => CommerceState(
        isLoading: false,
        errorMessage: null,
        showForm: false,
        columns: columns,
        data: [],
        departmentOptions: []
      );

  @override
  CommerceState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data,
    List<Department>? departmentOptions
  }) =>
      CommerceState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data,
        departmentOptions: departmentOptions ?? this.departmentOptions
      );
}