import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:delivery_app/presentation/notifier/reset_password/reset_password_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of resetPassword state created', () {
    ResetPasswordState state = StateMocks.resetPasswordStateMock;
    expect(state.status, AuthStatus.loading);
    expect(state.errorMessage, isNull);
  });

  test('Validate properties of resetPassword state copied', () {
    ResetPasswordState statePrevious = StateMocks.resetPasswordStateMock;
    ResetPasswordState state = statePrevious.copyWith(status: AuthStatus.success);
    expect(state.status, AuthStatus.success);
    expect(state.errorMessage, isNull);
  });
}