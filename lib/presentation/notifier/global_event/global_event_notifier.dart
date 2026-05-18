import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/date_data.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/create_global_event_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_all_global_events_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_global_event_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/update_global_event_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/upload_image_usecase.dart';
import 'package:delivery_app/presentation/notifier/global_event/global_event_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/widgets/map_location_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalEventNotifier extends StateNotifier<GlobalEventState> {
  final GetAllGlobalEventsUseCase getAllUseCase;
  final GetGlobalEventByIdUseCase getByIdUseCase;
  final CreateGlobalEventUseCase createUseCase;
  final UpdateGlobalEventUseCase updateUseCase;
  final GetDepartmentsUseCase getDepartmentsUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final GetProductsByCommerceUsecase getProductsByCommerceUsecase;
  final Rol rolConfig;

  GlobalEventNotifier(
      {required this.getAllUseCase,
      required this.getByIdUseCase,
      required this.createUseCase,
      required this.updateUseCase,
      required this.getDepartmentsUseCase,
      required this.uploadImageUseCase,
      required this.getProductsByCommerceUsecase,
      required this.rolConfig
      })
      : super(GlobalEventState.initial(Constants.headersEvents));

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final departments = await getDepartmentsUseCase();
      final functionConfig =
          rolConfig.functionConfig[Constants.globalEventFunction];
      state = state.copyWith(
          departmentOptions: departments,
          functionConfig: functionConfig,);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await getAllUseCase();
      final data = items.map((e) => e.toMap()).toList();
      state = state.copyWith(isLoading: false, data: data);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> create(Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      GlobalEvent model = mapFromFormData(map);
      await createUseCase(model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> update(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      GlobalEvent model = mapFromFormData(map);
      await updateUseCase(id, model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateFromTable(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      GlobalEvent model = GlobalEvent.fromMap(map);
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

  GlobalEvent mapFromFormData(Map<String, dynamic> map) {
      CityData cityData = map['cityDepartment'] as CityData;
      DateData programmedDate = map['scheduleDate'] as DateData;
      MapLocationData mapLocationData = map['location'] as MapLocationData;
      return GlobalEvent(
          id: map['id'] as String? ?? '',
          name: map['name'] as String? ?? '',
          department: cityData.department,
          city: cityData.city,
          status:  map['status'] as String? ?? Constants.programmedStatus, 
          description: map['description'] as String? ?? '',
          latitude: mapLocationData.latitude,
          longitude: mapLocationData.longitude,
          radious: mapLocationData.radious,
          startDate: map['startDate'] as String? ?? '',
          endDate: map['endDate'] as String? ?? '',
          scheduleDate: programmedDate.fullDate,
          );
  }
}

final globalEventNotifierProvider =
    StateNotifierProvider<GlobalEventNotifier, GlobalEventState>((ref) {
      final rolConfig = ref.read(sessionNotifierProvider).rolConfig ?? Constants.defaultRol;
  return GlobalEventNotifier(
      getAllUseCase: ref.read(getAllGlobalEventsUseCaseProvider),
      getByIdUseCase: ref.read(getGlobalEventByIdUseCaseProvider),
      createUseCase: ref.read(createGlobalEventUseCaseProvider),
      updateUseCase: ref.read(updateGlobalEventUseCaseProvider),
      getDepartmentsUseCase: ref.read(getDepartmentsUseCaseProvider),
      uploadImageUseCase: ref.read(uploadImageUseCaseProvider),
      getProductsByCommerceUsecase: ref.read(getAllProductsUseCaseProvider),
      rolConfig: rolConfig,);
});