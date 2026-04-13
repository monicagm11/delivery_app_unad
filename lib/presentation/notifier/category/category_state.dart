import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';

class CategoryState extends CrudState {
  CategoryState(
      {required super.isLoading,
      required super.showForm,
      required super.columns,
      required super.data,
      super.errorMessage,});

  factory CategoryState.initial(List<TableColumnConfig> columns) =>
      CategoryState(
          isLoading: false,
          errorMessage: null,
          showForm: false,
          columns: columns,
          data: [],);

  @override
  CategoryState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data
  }) =>
      CategoryState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data
      );
}
