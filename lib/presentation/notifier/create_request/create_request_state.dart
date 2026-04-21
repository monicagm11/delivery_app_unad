import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/crud_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';

class CreateRequestState extends CrudState {
  List<GlobalEvent> globalEventOptions;
  List<GlobalEvent> globalEventAvailableOptions;
  List<CheckboxOption> productOptions; 
  CreateRequestState({
    required this.globalEventOptions,
    required super.isLoading,
    super.errorMessage,
    required super.showForm,
    required super.columns,
    required super.data,
    required super.functionConfig,
    required this.productOptions,
    required this.globalEventAvailableOptions
  });

  factory CreateRequestState.initial(List<TableColumnConfig> columns) => CreateRequestState(
        isLoading: false,
        errorMessage: null,
        showForm: false,
        columns: columns,
        data: [],
        globalEventOptions: [],
        functionConfig: Constants.defaultFunctionConfig,
        productOptions: [],
        globalEventAvailableOptions: []
      );

  @override
  CreateRequestState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<TableColumnConfig>? columns,
    List<Map<String, dynamic>>? data,
    List<GlobalEvent>? globalEventOptions,
    FunctionConfig? functionConfig,
    List<CheckboxOption>? productOptions,
    List<GlobalEvent>? globalEventAvailableOptions,
  }) =>
      CreateRequestState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showForm: showForm ?? this.showForm,
        columns: columns ?? this.columns,
        data: data ?? this.data,
        globalEventOptions: globalEventOptions ?? this.globalEventOptions,
        functionConfig: functionConfig ?? this.functionConfig,
        productOptions: productOptions ?? this.productOptions,
        globalEventAvailableOptions: globalEventAvailableOptions ?? this.globalEventAvailableOptions
      );
}