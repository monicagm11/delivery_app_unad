import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/presentation/notifier/login/auth_state.dart';

class RegisterState {
  final AuthStatus status;
  final String? errorMessage;
  final User? user;
  final Rol? rolConfig;
  final String? userName;
  final String? rolId;

  const RegisterState(
      {this.status = AuthStatus.idle,
      this.user,
      this.rolConfig,
      this.userName,
      this.rolId,
      this.errorMessage});

  RegisterState copyWith(
          {AuthStatus? status,
          String? errorMessage,
          String? userName,
          String? rolId,
          Rol? rolConfig,
          User? user}) =>
      RegisterState(
          status: status ?? this.status,
          user: user ?? this.user,
          rolConfig: rolConfig ?? this.rolConfig,
          userName: userName ?? this.userName,
          rolId: rolId ?? this.rolId,
          errorMessage: errorMessage ?? this.errorMessage);
}
