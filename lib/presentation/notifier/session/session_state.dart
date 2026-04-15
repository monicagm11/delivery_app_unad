import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/rol.dart';

class SessionState {
  final String? userId;
  final String? email;
  final String? commerceId;
  final String? rol;
  final Rol? rolConfig;
  final Commerce? commerce;

  const SessionState({this.userId, this.email, this.commerceId, this.rol, this.rolConfig, this.commerce});

  SessionState copyWith({
    String? userId,
    String? email,
    String? commerceId,
    String? rol,
    Rol? rolConfig,
    Commerce? commerce
  }) {
    return SessionState(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      rol: rol ?? this.rol,
      commerceId: commerceId ?? this.commerceId,
      rolConfig: rolConfig ?? this.rolConfig,
      commerce: commerce ?? this.commerce
    );
  }
}