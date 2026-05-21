import 'package:delivery_app/domain/usecases/auth/reset_password_usecase.dart';
import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:delivery_app/presentation/notifier/reset_password/reset_password_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordNotifer extends StateNotifier<ResetPasswordState> {
  final ResetPasswordUseCase resetUseCase;

  ResetPasswordNotifer({required this.resetUseCase})
      : super(const ResetPasswordState());

  Future<void> reset(String email) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      await resetUseCase(email: email);

      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(
          status: AuthStatus.error, errorMessage: e.toString());
    }
  }

  void resetState() => state = const ResetPasswordState();
}

final resetPasswordNotifierProvider =
    StateNotifierProvider<ResetPasswordNotifer, ResetPasswordState>((ref) {
  return ResetPasswordNotifer(
    resetUseCase: ref.read(resetPasswordUseCaseProvider)
  );
});