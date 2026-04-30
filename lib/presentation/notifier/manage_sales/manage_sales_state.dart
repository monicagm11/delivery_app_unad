import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';

import '../../../domain/entities/rol.dart';

class ManageSalesState extends CrudState {
  ManageSalesState(
      {required super.isLoading,
      required super.showForm,
      required super.columns,
      required super.data,
      required super.functionConfig,
      super.errorMessage,
      required this.items});
  List<CheckoutOrder> items;

  factory ManageSalesState.initial(List<TableColumnConfig> columns) => ManageSalesState(
        isLoading: false,
        errorMessage: null,
        showForm: false,
        columns: columns,
        data: [],
        functionConfig: Constants.defaultFunctionConfig, 
        items: []
      );

  @override
  ManageSalesState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data,
    FunctionConfig? functionConfig,
    List<CheckoutOrder>? items
  }) =>
      ManageSalesState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data,
        functionConfig: functionConfig ?? this.functionConfig,
        items: items ?? this.items
      );
}
