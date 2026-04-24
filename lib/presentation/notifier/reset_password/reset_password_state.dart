import 'package:delivery_app/presentation/notifier/login/auth_state.dart';

class ResetPasswordState {
  final AuthStatus status;
  final String? errorMessage;

  const ResetPasswordState(
      {this.status = AuthStatus.idle, this.errorMessage});

  ResetPasswordState copyWith(
          {AuthStatus? status, String? errorMessage}) =>
      ResetPasswordState(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage
          );
}
