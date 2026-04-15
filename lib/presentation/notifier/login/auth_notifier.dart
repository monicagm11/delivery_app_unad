import 'package:delivery_app/domain/usecases/login_usecase.dart';
import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final Ref ref;

  AuthNotifier({required this.loginUseCase, required this.ref})
      : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final credential = await loginUseCase(email: email, password: password);
      final user = credential.user;
      if (user == null) throw Exception('Usuario no encontrado.');

      await ref.read(sessionNotifierProvider.notifier).setSession(user.uid);

      state = state.copyWith(status: AuthStatus.success, userId: user.uid);
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
    ref: ref,
  );
});
