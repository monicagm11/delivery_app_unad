class SessionState {
  final String? userId;
  final String? email;
  final String? commerceId;
  final String? rol;

  const SessionState({this.userId, this.email, this.commerceId, this.rol});

  SessionState copyWith({
    String? userId,
    String? email,
    String? commerceId,
    String? rol
  }) {
    return SessionState(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      rol: rol ?? this.rol,
      commerceId: commerceId ?? this.commerceId
    );
  }
}