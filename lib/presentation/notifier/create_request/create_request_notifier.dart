import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/create_request/create_request_event_usecase.dart';
import 'package:delivery_app/domain/usecases/create_request/get_request_events_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/create_request/update_request_event_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_all_global_events_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/presentation/notifier/create_request/create_request_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreateRequestEventNotifier extends StateNotifier<CreateRequestState> {
  final GetRequestEventsByCommerceUseCase getAllUseCase;
  final CreateRequestEventUseCase createUseCase;
  final UpdateRequestEventUseCase updateUseCase;
  final GetProductsByCommerceUsecase getProductsByCommerceUsecase;
  final GetAllGlobalEventsUseCase getAllGlobalEventUsecase;
  final Rol rolConfig;
  final String commerceId;

  CreateRequestEventNotifier(
      {required this.getAllUseCase,
      required this.createUseCase,
      required this.updateUseCase,
      required this.getProductsByCommerceUsecase,
      required this.getAllGlobalEventUsecase,
      required this.rolConfig,
      required this.commerceId
      })
      : super(CreateRequestState.initial(Constants.headersCreateRequestEvents));

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final products = await getProductsByCommerceUsecase(commerceId);
      final productsAvailables = products
          .where((e) => e.status == 'ACTIVO')
          .map((e) => CheckboxOption(label: e.name, value: e.id))
          .toList();
      final functionConfig =
          rolConfig.functionConfig[Constants.eventFunction];
      final globalEvents = await getAllGlobalEventUsecase.call();
      final globalEventsAvailable = globalEvents.where((e)=> e.status == Constants.publishedStatus).toList();
      state = state.copyWith(
          functionConfig: functionConfig,
          productOptions: productsAvailables,
          globalEventAvailableOptions: globalEventsAvailable,
          globalEventOptions: globalEvents);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await getAllUseCase(commerceId);
      final data = items.map((e){
        Map<String, dynamic> data = e.toMap();
        GlobalEvent event = state.globalEventOptions.firstWhere((e) => e.id == data['eventId']);
        data['eventName'] = event.name;
        data['eventDescription'] = event.description;
        data['scheduleDate'] = event.scheduleDate;
        return data;
      } ).toList();
      state = state.copyWith(isLoading: false, data: data);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> create(Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      RequestEvent model = mapFromFormData(map);
      await createUseCase(model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> update(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      RequestEvent model = mapFromFormData(map);
      await updateUseCase(id, model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateFromTable(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      RequestEvent model = RequestEvent.fromMap(map);
      await updateUseCase(id, model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void openForm() {
    state = state.copyWith(showForm: true);
  }

  void closeForm() {
    state = state.copyWith(showForm: false);
  }

  RequestEvent mapFromFormData(Map<String, dynamic> map) {
    GlobalEvent event = map['event'] as GlobalEvent;
    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);
    List<CheckboxOption> productList = map['products'] as List<CheckboxOption>? ?? [];
    List<String> productIdList = productList.map((e) => e.value).toList();
      return RequestEvent(
          id: map['id'] as String? ?? '',
          status: map['status'] as String? ?? Constants.pendindStatus,  
          commerceId: commerceId,
          eventId: event.id, 
          creationDate: formattedDate, 
          productsIdList: productIdList,
          locationClientType: map['locationClientType']
          );
  }
}

final createRequestEventNotifierProvider =
    StateNotifierProvider<CreateRequestEventNotifier, CreateRequestState>((ref) {
      final commerceId =
      ref.read(sessionNotifierProvider).commerce?.id ?? '';
      final rolConfig = ref.read(sessionNotifierProvider).rolConfig ?? Constants.defaultRol;
  return CreateRequestEventNotifier(
      getAllUseCase: ref.read(getRequestEventsByCommerceUseCaseProvider),
      createUseCase: ref.read(createRequestEventUseCaseProvider),
      updateUseCase: ref.read(updateRequestEventUseCaseProvider),
      getProductsByCommerceUsecase: ref.read(getAllProductsUseCaseProvider),
      getAllGlobalEventUsecase: ref.read(getAllGlobalEventsUseCaseProvider),
      rolConfig: rolConfig,
      commerceId: commerceId);
});