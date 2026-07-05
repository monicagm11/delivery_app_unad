import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/rol_data.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/commerce/get_all_commercers_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/send_email_new_users_usecase.dart';
import 'package:delivery_app/domain/usecases/user/create_user_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_all_user_usecase.dart';
import 'package:delivery_app/domain/usecases/user/update_user_usecase.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/notifier/user/user_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserState> {
  final GetAllUsersUseCase getAllUseCase;
  final CreateUserUseCase createUseCase;
  final UpdateUserUseCase updateUseCase;
  final GetDepartmentsUseCase getDepartmentsUseCase;
  final GetAllCommercesUseCase getAllCommercesUseCase;
  final SendEmailNewUsersUsecase sendEmailNewUsersUsecase;
  final String commerceId;
  final Rol rolConfig;

  UserNotifier(
      {required this.getAllUseCase,
      required this.createUseCase,
      required this.updateUseCase,
      required this.getDepartmentsUseCase,
      required this.getAllCommercesUseCase,
      required this.sendEmailNewUsersUsecase,
      required this.commerceId,
      required this.rolConfig
      })
      : super(UserState.initial(Constants.headersUsers));

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final departments = await getDepartmentsUseCase();
      final currentRol = rolConfig.code;
      List<DropdownOption> commerceOptions = [];
      if (currentRol == Constants.adminRolCode) {
        final commerces = await getAllCommercesUseCase();
        commerceOptions = commerces
          .map((e) => DropdownOption(label: e.name, value: e.id))
          .toList();
      } else {
        commerceOptions = [DropdownOption(label: commerceId, value: commerceId)];
      }
      
      final roles = rolConfig.rolEnableToCreate;
      final rolOptions =
          roles.map((e) => DropdownOption(label: e, value: e)).toList();
      
      final functionConfig = rolConfig.functionConfig[Constants.userFunction];

      state = state.copyWith(
          departmentOptions: departments,
          commerceOptions: commerceOptions,
          rolOptions: rolOptions,
          functionConfig: functionConfig ?? Constants.defaultFunctionConfig
          );
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
      state = state.copyWith(isLoading: false, errorMessage: e.toString(), data: []);
    }
  }

  Future<void> create(Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      String userId = await sendEmailNewUsersUsecase(email: map['email'], name: map['name']);
      map['userId'] = userId;
      map['isPending'] = true;
      User model = mapFromFormData(map);
      await createUseCase(model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> update(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      User model = mapFromFormData(map);
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

  User mapFromFormData(Map<String, dynamic> map) {
    IdentificationData identificationData =
          map['identification'] as IdentificationData;
      CityData cityData = map['cityDepartment'] as CityData;
      RolData rolData = map['rol'] as RolData;
      return User(
          id: map['id'] as String? ?? '',
          userId: map['userId'] as String? ?? '',
          name: map['name'] as String? ?? '',
          lastname: map['lastname'] as String? ?? '',
          fullname: '${map['name']} ${map['lastname']}',
          document: identificationData.number,
          identificationType: identificationData.code,
          phone: map['phone'] as String? ?? '',
          address: map['address'] as String? ?? '',
          email: map['email'] as String? ?? '',
          department: cityData.department,
          city: cityData.city,
          status: map['status'] as String? ?? '',
          fullDocument: identificationData.full,
          rol: rolData.rol,
          commerce: rolData.commerce,
          occupation: map['occupation']
          );
  }
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) {
      final commerceId =
      ref.read(sessionNotifierProvider).commerce?.id ?? '';
      final rolConfig = ref.read(sessionNotifierProvider).rolConfig ?? Constants.defaultRol;
  return UserNotifier(
      getAllUseCase: ref.read(getAllUsersUseCaseProvider),
      createUseCase: ref.read(createUserUseCaseProvider),
      updateUseCase: ref.read(updateUserUseCaseProvider),
      getDepartmentsUseCase: ref.read(getDepartmentsUseCaseProvider),
      getAllCommercesUseCase: ref.read(getAllCommercesUseCaseProvider),
      sendEmailNewUsersUsecase: ref.read(sendEmailNewUsersUseCaseProvider),
      commerceId: commerceId,
      rolConfig: rolConfig 
      );
});