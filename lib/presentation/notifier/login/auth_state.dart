enum AuthStatus { idle, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? userId;

  const AuthState({this.status = AuthStatus.idle, this.errorMessage, this.userId});

  AuthState copyWith({AuthStatus? status, String? errorMessage, String? userId}) => AuthState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        userId: userId ?? this.userId
        );
}
