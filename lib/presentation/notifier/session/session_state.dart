import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/user.dart';

class SessionState {
  final User? user;
  final Rol? rolConfig;
  final Commerce? commerce;
  final String? userName;
  final String? rolId;

  const SessionState({this.user, this.rolConfig, this.commerce, this.userName, this.rolId});

  SessionState copyWith({
    User? user,
    String? userName,
    Rol? rolConfig,
    Commerce? commerce,
    String? rolId
  }) {
    return SessionState(
      user: user ?? this.user,
      rolConfig: rolConfig ?? this.rolConfig,
      commerce: commerce ?? this.commerce,
      userName: userName ?? this.userName,
      rolId: rolId ?? this.rolId
    );
  }
}