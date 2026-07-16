import 'package:delivery_app/domain/entities/user.dart' as user;
import 'package:delivery_app/domain/usecases/functions/get_remote_config_usecase.dart';
import 'package:delivery_app/domain/usecases/user/create_user_usecase.dart';
import 'package:delivery_app/domain/usecases/user/register_user_usecase.dart';
import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:delivery_app/presentation/notifier/register/register_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterNotifer extends StateNotifier<RegisterState> {
  final RegisterUserUsecase registerUserUsecase;
  final CreateUserUseCase createUserUseCase;
  final GetRemoteConfigUsecase getRemoteConfigUsecase;

  RegisterNotifer({required this.registerUserUsecase, required this.createUserUseCase, required this.getRemoteConfigUsecase})
      : super(const RegisterState());

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      String? lastname,
      required String phone}) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      UserCredential credential =  await registerUserUsecase(email: email, password: password);
      final credentialUser = credential.user;

      user.User userData = user.User(
          id: credentialUser!.uid,
          name: name,
          lastname: lastname,
          email: email,
          userId: credentialUser.uid,
          rol: Constants.userRolCode,
          status: 'ACTIVO');
          
      createUserUseCase.call(userData);

      final rolInfo = await getRemoteConfigUsecase.call(userData.rol);

      state = state.copyWith(status: AuthStatus.success, rolConfig: rolInfo, user: userData, userName: name, rolId: Constants.userRolCode);
    } catch (e) {
      state =
          state.copyWith(status: AuthStatus.error, errorMessage: e.toString());
    }
  }

  void resetState() => state = const RegisterState();
}

final registerNotifierProvider =
    StateNotifierProvider<RegisterNotifer, RegisterState>((ref) {
  return RegisterNotifer(
    registerUserUsecase: ref.read(registerUseCaseProvider),
    createUserUseCase: ref.read(createUserUseCaseProvider),
    getRemoteConfigUsecase: ref.read(getRemoteConfigUsecaseProvider),
  );
});