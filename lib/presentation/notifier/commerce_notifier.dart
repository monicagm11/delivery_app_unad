import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:delivery_app/domain/usecases/commerce/create_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_all_commercers_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/update_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/get_departments_usecase.dart';
import 'package:delivery_app/presentation/notifier/commerce_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceNotifier extends StateNotifier<CommerceState> {
  final GetAllCommercesUseCase getAllUseCase;
  final GetCommerceByIdUseCase getByIdUseCase;
  final CreateCommerceUseCase createUseCase;
  final UpdateCommerceUseCase updateUseCase;
  final GetDepartmentsUseCase getDepartmentsUseCase;

  CommerceNotifier(
      {required this.getAllUseCase,
      required this.getByIdUseCase,
      required this.createUseCase,
      required this.updateUseCase,
      required this.getDepartmentsUseCase})
      : super(CommerceState.initial(Constants.headersCommerce));

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final departments = await getDepartmentsUseCase();
      state = state.copyWith(departmentOptions: departments);
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
      CommerceModel model = mapFromFormData(map);
      await createUseCase(model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> update(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      CommerceModel model = mapFromFormData(map);
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

  CommerceModel mapFromFormData(Map<String, dynamic> map) {
    IdentificationData identificationData =
          map['identification'] as IdentificationData;
      CityData cityData = map['cityDepartment'] as CityData;
      return CommerceModel(
          id: map['id'] as String? ?? '',
          name: map['name'] as String? ?? '',
          document: identificationData.number,
          identificationType: identificationData.code,
          phone: map['phone'] as String? ?? '',
          address: map['address'] as String? ?? '',
          email: map['email'] as String? ?? '',
          department: cityData.department,
          city: cityData.city,
          status: map['status'] as String? ?? '',
          contactName: map['contactName'] as String? ?? '',
          fullDocument: identificationData.full);
  }
}

final commerceNotifierProvider =
    StateNotifierProvider<CommerceNotifier, CommerceState>((ref) {
  return CommerceNotifier(
      getAllUseCase: ref.read(getAllCommercesUseCaseProvider),
      getByIdUseCase: ref.read(getCommerceByIdUseCaseProvider),
      createUseCase: ref.read(createCommerceUseCaseProvider),
      updateUseCase: ref.read(updateCommerceUseCaseProvider),
      getDepartmentsUseCase: ref.read(getDepartmentsUseCaseProvider));
});
