import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/create_request/get_all_request_event_usecases.dart';
import 'package:delivery_app/domain/usecases/create_request/update_request_event_usecase.dart';
import 'package:delivery_app/domain/usecases/event/create_event_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_all_global_events_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/presentation/notifier/manage_request/manage_request_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageRequestEventNotifier extends StateNotifier<ManageRequestState> {
  final GetAllRequestEventsUseCase getAllUseCase;
  final UpdateRequestEventUseCase updateUseCase;
  final GetProductsByCommerceUsecase getProductsByCommerceUsecase;
  final GetAllGlobalEventsUseCase getActiveGlobalEventUsecase;
  final CreateLocalEventUseCase createLocalEventUseCase;
  final Rol rolConfig;
  final String commerceId;

  ManageRequestEventNotifier(
      {required this.getAllUseCase,
      required this.updateUseCase,
      required this.getProductsByCommerceUsecase,
      required this.getActiveGlobalEventUsecase,
      required this.createLocalEventUseCase,
      required this.rolConfig,
      required this.commerceId
      })
      : super(ManageRequestState.initial(Constants.headersCreateRequestEvents));

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final globalEventsAvailable = await getActiveGlobalEventUsecase.call();
      final functionConfig =
          rolConfig.functionConfig[Constants.eventRequestFunction];
      state = state.copyWith(
          functionConfig: functionConfig, globalEventOptions: globalEventsAvailable);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
  Future<void> setProducts(Map<String, dynamic> map) async {
    try {
      String? currentCommerceId = map['commerceId'] as String?;
      if(currentCommerceId== null || currentCommerceId.trim().isEmpty) return;
      final products = await getProductsByCommerceUsecase(currentCommerceId);
      final productsAvailables = products
          .where((e) => e.status == 'ACTIVO')
          .map((e) => CheckboxOption(label: e.name, value: e.id))
          .toList();
  
      state = state.copyWith(
          productOptions: productsAvailables);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await getAllUseCase();
      final data = items.map((e){
        Map<String, dynamic> data = e.toMap();
        GlobalEvent event = state.globalEventOptions.firstWhere((e) => e.id == data['eventId']);
        data['eventName'] = event.name;
        data['eventDescription'] = event.description;
        data['scheduleDate'] = event.scheduleDate;
        data['longitude'] = event.longitude;
        data['latitude'] = event.latitude;
        data['radious'] = event.radious;
        data['department'] = event.department;
        data['city'] = event.city;
        return data;
      } ).toList();
      state = state.copyWith(isLoading: false, data: data);
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

  Future<void> approveRequestFromTable(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      RequestEvent model = RequestEvent.fromMap(map);
      await updateUseCase(id, model);
      LocalEvent modelLocalEvent = LocalEvent(
          id: '',
          name: map['eventName'] as String? ?? '',
          department: map['department'],
          city: map['city'],
          status: Constants.programmedStatus, 
          description: map['eventDescription'] as String? ?? '',
          latitude: map['latitude'] ,
          longitude: map['longitude'],
          radious: map['radious'],
          startDate: map['startDate'] as String? ?? '',
          endDate: map['endDate'] as String? ?? '',
          scheduleDate: map['scheduleDate'] as String? ?? '',
          productsIdList: map['products'] as List<String>,
          commerce: map['commerceId'],
          idGlobalEvent: map['id'],
          locationClientType: map['locationClientType'],
          );
      await createLocalEventUseCase(modelLocalEvent);
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
      return RequestEvent(
          id: map['id'] as String? ?? '',
          status: map['status'] as String? ?? Constants.pendindStatus,  
          commerceId: map['commerceId'] as String,
          eventId: 'event.id', 
          creationDate: 'formattedDate', 
          productsIdList: [],
          locationClientType: map['locationClientType'] as String? ?? ''
          );
  }
}

final manageRequestEventNotifierProvider =
    StateNotifierProvider<ManageRequestEventNotifier, ManageRequestState>((ref) {
      final commerceId =
      ref.read(sessionNotifierProvider).commerce?.id ?? '';
      final rolConfig = ref.read(sessionNotifierProvider).rolConfig ?? Constants.defaultRol;
  return ManageRequestEventNotifier(
      getAllUseCase: ref.read(getAllRequestEventsUseCaseProvider),
      updateUseCase: ref.read(updateRequestEventUseCaseProvider),
      getProductsByCommerceUsecase: ref.read(getAllProductsUseCaseProvider),
      getActiveGlobalEventUsecase: ref.read(getAllGlobalEventsUseCaseProvider),
      createLocalEventUseCase: ref.read(createLocalEventUseCaseProvider),
      rolConfig: rolConfig,
      commerceId: commerceId);
});