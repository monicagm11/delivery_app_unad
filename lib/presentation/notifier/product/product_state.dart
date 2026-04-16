import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';

class ProductState extends CrudState {
  List<DropdownOption> categoryOptions;
  List<Category> categories;
  ProductState({
    required this.categoryOptions,
    required super.isLoading,
    super.errorMessage,
    required super.showForm,
    required super.columns,
    required super.data,
    required super.functionConfig,
    required this.categories
  });

  factory ProductState.initial(List<TableColumnConfig> columns) => ProductState(
        isLoading: false,
        errorMessage: null,
        showForm: false,
        columns: columns,
        data: [],
        categoryOptions: [],
        categories: [],
        functionConfig: Constants.defaultFunctionConfig
      );

  @override
  ProductState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data,
    List<DropdownOption>? categoryOptions,
    List<Category>? categories,
    FunctionConfig? functionConfig
  }) =>
      ProductState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data,
        categoryOptions: categoryOptions ?? this.categoryOptions,
        functionConfig: functionConfig ?? this.functionConfig,
        categories: categories ?? this.categories
      );
}