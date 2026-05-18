import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/get_remote_config_usecase.dart';
import 'package:delivery_app/domain/usecases/login_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final GetCommerceByIdUseCase getCommerceByIdUseCase;
  final GetRemoteConfigUsecase getRemoteConfigUsecase;

  AuthNotifier({required this.loginUseCase, required this.getCommerceByIdUseCase,
      required this.getUserByIdUseCase,
      required this.getRemoteConfigUsecase})
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

      state = state.copyWith(
          status: AuthStatus.success,
          user: userData,
          userName: userData.fullname,
          commerce: commerce,
          rolConfig: rolInfo,
          rolId: userData.rol);
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
  );
});
