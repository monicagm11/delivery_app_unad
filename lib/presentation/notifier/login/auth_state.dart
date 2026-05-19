import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/user.dart';

enum AuthStatus { idle, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final User? user;
  final Rol? rolConfig;
  final Commerce? commerce;
  final String? userName;
  final String? rolId;
  final bool? hasCitySelected;

  const AuthState(
      {this.status = AuthStatus.idle,
      this.errorMessage,
      this.user,
      this.rolConfig,
      this.commerce,
      this.userName,
      this.rolId,
      this.hasCitySelected});

  AuthState copyWith(
          {AuthStatus? status,
          String? errorMessage,
          User? user,
          String? userName,
          Rol? rolConfig,
          Commerce? commerce,
          String? rolId,
          bool? hasCitySelected}) =>
      AuthState(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          user: user ?? this.user,
          rolConfig: rolConfig ?? this.rolConfig,
          commerce: commerce ?? this.commerce,
          userName: userName ?? this.userName,
          rolId: rolId ?? this.rolId,
          hasCitySelected: hasCitySelected ?? this.hasCitySelected);
}
