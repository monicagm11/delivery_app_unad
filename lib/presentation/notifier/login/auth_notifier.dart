import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/get_remote_config_usecase.dart';
import 'package:delivery_app/domain/usecases/local_storage/get_string_localstorage_usecase.dart';
import 'package:delivery_app/domain/usecases/auth/login_google_usecase.dart';
import 'package:delivery_app/domain/usecases/auth/login_usecase.dart';
import 'package:delivery_app/domain/usecases/user/create_user_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final GetCommerceByIdUseCase getCommerceByIdUseCase;
  final GetRemoteConfigUsecase getRemoteConfigUsecase;
  final GetStringLocalstorageUsecase getStringLocalstorageUsecase;
  final LoginGoogleUsecase loginGoogleUsecase;
  final CreateUserUseCase createUseCase;

  AuthNotifier({required this.loginUseCase, required this.getCommerceByIdUseCase,
      required this.getUserByIdUseCase,
      required this.getRemoteConfigUsecase,
      required this.getStringLocalstorageUsecase,
      required this.loginGoogleUsecase,
      required this.createUseCase})
      : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final credential = await loginUseCase(email: email, password: password);
      final user = credential.user;
      if (user == null) throw Exception('Usuario no registrado.');
      User? userData = await getUserByIdUseCase.call(user.uid);
      if (userData == null) throw Exception('Usuario no encontrado.');
      if (userData.status != 'ACTIVO')  throw Exception('Usuario inactivo.');
      Commerce? commerce;
      if (userData.commerce != null && userData.commerce!.isNotEmpty) {
        commerce = await getCommerceByIdUseCase.call(userData.commerce!);
        if (commerce?.status != 'ACTIVO')  throw Exception('Comercio inactivo.');
      }
      final rolInfo = await getRemoteConfigUsecase.call(userData.rol);

      bool? hasCity;

      if (userData.rol == Constants.userRolCode) {
        String? citySelected = await getStringLocalstorageUsecase(Constants.keyCity);
        hasCity = citySelected != null && citySelected.isNotEmpty;
      }

      state = state.copyWith(
          status: AuthStatus.success,
          user: userData,
          userName: userData.fullname,
          commerce: commerce,
          rolConfig: rolInfo,
          rolId: userData.rol,
          hasCitySelected: hasCity);
    } catch (e) {
      state = state.copyWith(
          status: AuthStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final credential = await loginGoogleUsecase();
      final user = credential.user;
      if (user == null) throw Exception('Usuario no registrado.');
      User? userData = await getUserByIdUseCase.call(user.uid);
      if (userData == null) {
        userData = User(id: '', name: user.displayName ?? '', fullname: user.displayName ?? '', email: user.email!, userId: user.uid, status: 'ACTIVO', rol: Constants.userRolCode);
        await createUseCase(userData);
      }
      if (userData.status != 'ACTIVO')  throw Exception('Usuario inactivo.');
      Commerce? commerce;
      if (userData.commerce != null && userData.commerce!.isNotEmpty) {
        commerce = await getCommerceByIdUseCase.call(userData.commerce!);
        if (commerce?.status != 'ACTIVO')  throw Exception('Comercio inactivo.');
      }
      final rolInfo = await getRemoteConfigUsecase.call(userData.rol);

      bool? hasCity;

      if (userData.rol == Constants.userRolCode) {
        String? citySelected = await getStringLocalstorageUsecase(Constants.keyCity);
        hasCity = citySelected != null && citySelected.isNotEmpty;
      }

      state = state.copyWith(
          status: AuthStatus.success,
          user: userData,
          userName: userData.fullname,
          commerce: commerce,
          rolConfig: rolInfo,
          rolId: userData.rol,
          hasCitySelected: hasCity);
    } catch (e) {
      state = state.copyWith(
          status: AuthStatus.error, errorMessage: e.toString());
    }
  }

  void resetState() => state = const AuthState();
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    loginUseCase: ref.read(loginUseCaseProvider),
    getCommerceByIdUseCase: ref.read(getCommerceByIdUseCaseProvider),
    getUserByIdUseCase: ref.read(getUserByIdUseCaseProvider),
    getRemoteConfigUsecase: ref.read(getRemoteConfigUsecaseProvider),
    getStringLocalstorageUsecase: ref.read(getStringUseCaseProvider),
    loginGoogleUsecase: ref.read(loginGoogleUseCaseProvider),
    createUseCase: ref.read(createUserUseCaseProvider),
  );
});
