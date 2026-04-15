import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';

class UserState extends CrudState {
  List<Department> departmentOptions;
  List<DropdownOption> commerceOptions;
  List<DropdownOption> rolOptions;
  UserState(
      {required super.isLoading,
      required super.showForm,
      required super.columns,
      required super.data,
      required this.departmentOptions,
      required this.commerceOptions,
      required this.rolOptions,
      super.errorMessage,});

  factory UserState.initial(List<TableColumnConfig> columns) =>
      UserState(
          isLoading: false,
          errorMessage: null,
          showForm: false,
          departmentOptions: [],
          columns: columns,
          data: [],
          commerceOptions: [],
          rolOptions: []);

  @override
  UserState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data,
    List<Department>? departmentOptions,
    List<DropdownOption>? commerceOptions,
    List<DropdownOption>? rolOptions,
  }) =>
      UserState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data,
        departmentOptions: departmentOptions ?? this.departmentOptions,
        commerceOptions: commerceOptions ?? this.commerceOptions,
        rolOptions: rolOptions ?? this.rolOptions
      );
}
