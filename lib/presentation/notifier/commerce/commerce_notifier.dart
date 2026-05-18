import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:delivery_app/domain/entities/image_data.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/commerce/create_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_all_commercers_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/update_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/upload_image_usecase.dart';
import 'package:delivery_app/presentation/notifier/commerce/commerce_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceNotifier extends StateNotifier<CommerceState> {
  final GetAllCommercesUseCase getAllUseCase;
  final GetCommerceByIdUseCase getByIdUseCase;
  final CreateCommerceUseCase createUseCase;
  final UpdateCommerceUseCase updateUseCase;
  final GetDepartmentsUseCase getDepartmentsUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final Rol rolConfig;

  CommerceNotifier(
      {required this.getAllUseCase,
      required this.getByIdUseCase,
      required this.createUseCase,
      required this.updateUseCase,
      required this.getDepartmentsUseCase,
      required this.uploadImageUseCase,
      required this.rolConfig,
      })
      : super(CommerceState.initial(Constants.headersCommerce));

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final departments = await getDepartmentsUseCase();
      final functionConfig = rolConfig.functionConfig[Constants.commerceFunction];
      state = state.copyWith(departmentOptions: departments, functionConfig: functionConfig);
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
      ImageData imageData = map['urlImage'] as ImageData;
      final urlImage = await uploadImageUseCase(path: imageData.path!, folder: imageData.folder, bytes: imageData.bytes);
      ImageData imageDataQR = map['urlImageQR'] as ImageData;
      final urlImageQR = await uploadImageUseCase(path: imageDataQR.path!, folder: imageDataQR.folder, bytes: imageDataQR.bytes);
      map['urlImage'] = urlImage;
      map['urlImageQR'] = urlImageQR;
      Commerce model = mapFromFormData(map);
      await createUseCase(model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> update(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      ImageData imageData = map['urlImage'] as ImageData;
      if (imageData.path!= null && !imageData.path!.contains(Constants.bucketName)) {
        final urlImage = await uploadImageUseCase(path: imageData.path!, folder: imageData.folder, bytes: imageData.bytes);
        map['urlImage'] = urlImage;
      } else {
        map['urlImage'] = imageData.path;
      }
      ImageData imageDataQR = map['urlImageQR'] as ImageData;
      if (imageDataQR.path!= null && !imageDataQR.path!.contains(Constants.bucketName)) {
        final urlImage = await uploadImageUseCase(path: imageDataQR.path!, folder: imageDataQR.folder, bytes: imageDataQR.bytes);
        map['urlImageQR'] = urlImage;
      } else {
        map['urlImageQR'] = imageDataQR.path;
      }
      Commerce model = mapFromFormData(map);
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

  Commerce mapFromFormData(Map<String, dynamic> map) {
    IdentificationData identificationData =
          map['identification'] as IdentificationData;
      CityData cityData = map['cityDepartment'] as CityData;
      return Commerce(
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
          urlImage: map['urlImage'] as String,
          urlImageQR: map['urlImageQR'] as String,
          fullDocument: identificationData.full);
  }
}

final commerceNotifierProvider =
    StateNotifierProvider<CommerceNotifier, CommerceState>((ref) {
      final rolConfig = ref.read(sessionNotifierProvider).rolConfig ?? Constants.defaultRol;
  return CommerceNotifier(
      getAllUseCase: ref.read(getAllCommercesUseCaseProvider),
      getByIdUseCase: ref.read(getCommerceByIdUseCaseProvider),
      createUseCase: ref.read(createCommerceUseCaseProvider),
      updateUseCase: ref.read(updateCommerceUseCaseProvider),
      getDepartmentsUseCase: ref.read(getDepartmentsUseCaseProvider),
      uploadImageUseCase: ref.read(uploadImageUseCaseProvider),
      rolConfig: rolConfig );
});
