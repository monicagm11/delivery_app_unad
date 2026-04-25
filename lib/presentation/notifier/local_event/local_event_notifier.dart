import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/date_data.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/event/create_event_usecase.dart';
import 'package:delivery_app/domain/usecases/event/get_all_events_usecase.dart';
import 'package:delivery_app/domain/usecases/event/get_event_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/event/update_event_usecase.dart';
import 'package:delivery_app/domain/usecases/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/upload_image_usecase.dart';
import 'package:delivery_app/presentation/notifier/local_event/local_event_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/widgets/map_location_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalEventNotifier extends StateNotifier<LocalEventState> {
  final GetAllLocalEventsUseCase getAllUseCase;
  final GetLocalEventByIdUseCase getByIdUseCase;
  final CreateLocalEventUseCase createUseCase;
  final UpdateLocalEventUseCase updateUseCase;
  final GetDepartmentsUseCase getDepartmentsUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final GetProductsByCommerceUsecase getProductsByCommerceUsecase;
  final Rol rolConfig;
  final String commerceId;

  LocalEventNotifier(
      {required this.getAllUseCase,
      required this.getByIdUseCase,
      required this.createUseCase,
      required this.updateUseCase,
      required this.getDepartmentsUseCase,
      required this.uploadImageUseCase,
      required this.getProductsByCommerceUsecase,
      required this.rolConfig,
      required this.commerceId
      })
      : super(LocalEventState.initial(Constants.headersEvents));

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final departments = await getDepartmentsUseCase();
      final products = await getProductsByCommerceUsecase(commerceId);
      final productsAvailables = products
          .where((e) => e.status == 'ACTIVO')
          .map((e) => CheckboxOption(label: e.name, value: e.id))
          .toList();
      final functionConfig =
          rolConfig.functionConfig[Constants.eventFunction];
      state = state.copyWith(
          departmentOptions: departments,
          functionConfig: functionConfig,
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
      final data = items.map((e) => e.toMap()).toList();
      state = state.copyWith(isLoading: false, data: data);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> create(Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      LocalEventModel model = mapFromFormData(map);
      await createUseCase(model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> update(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      LocalEventModel model = mapFromFormData(map);
      await updateUseCase(id, model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateFromTable(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      LocalEventModel model = LocalEventModel.fromMap(map);
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

  LocalEventModel mapFromFormData(Map<String, dynamic> map) {
      CityData cityData = map['cityDepartment'] as CityData;
      DateData programmedDate = map['scheduleDate'] as DateData;
      MapLocationData mapLocationData = map['location'] as MapLocationData;
      List<CheckboxOption> productList = map['products'] as List<CheckboxOption>? ?? [];
      List<String> productIdList = productList.map((e) => e.value).toList();

      return LocalEventModel(
          id: map['id'] as String? ?? '',
          name: map['name'] as String? ?? '',
          department: cityData.department,
          city: cityData.city,
          status:  map['status'] as String? ??  Constants.programmedStatus, 
          description: map['description'] as String? ?? '',
          latitude: mapLocationData.latitude,
          longitude: mapLocationData.longitude,
          radious: mapLocationData.radious,
          startDate: map['startDate'] as String? ?? '',
          endDate: map['endDate'] as String? ?? '',
          scheduleDate: programmedDate.fullDate,
          productsIdList: productIdList,
          commerce: commerceId
          );
  }
}

final localEventNotifierProvider =
    StateNotifierProvider<LocalEventNotifier, LocalEventState>((ref) {
      final commerceId =
      ref.read(sessionNotifierProvider).commerceId ?? '2G9IlFqKCL36mMaFF4Jg';
      final rolConfig = ref.read(sessionNotifierProvider).rolConfig ?? Constants.defaultRol;
  return LocalEventNotifier(
      getAllUseCase: ref.read(getAllLocalEventsUseCaseProvider),
      getByIdUseCase: ref.read(getLocalEventByIdUseCaseProvider),
      createUseCase: ref.read(createLocalEventUseCaseProvider),
      updateUseCase: ref.read(updateLocalEventUseCaseProvider),
      getDepartmentsUseCase: ref.read(getDepartmentsUseCaseProvider),
      uploadImageUseCase: ref.read(uploadImageUseCaseProvider),
      getProductsByCommerceUsecase: ref.read(getAllProductsUseCaseProvider),
      rolConfig: rolConfig,
      commerceId: commerceId);
});