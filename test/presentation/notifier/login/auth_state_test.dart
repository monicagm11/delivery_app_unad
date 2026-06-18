import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of auth state created', () {
    AuthState state = StateMocks.authStateMock;
    expect(state.status, AuthStatus.success);
    expect(state.user, isNotNull);
    expect(state.rolConfig, isNotNull);
    expect(state.errorMessage, isNull);
    expect(state.commerce, isNotNull);
    expect(state.userName, 'Magnolia Valle');
    expect(state.rolId, 'ADMINISTRADOR');
    expect(state.hasCitySelected, true);
  });

  test('Validate properties of auth state copied', () {
    AuthState statePrevious = StateMocks.authStateMock;
    AuthState state = statePrevious.copyWith(status: AuthStatus.loading);
    expect(state.status, AuthStatus.loading);
    expect(state.user, isNotNull);
    expect(state.rolConfig, isNotNull);
    expect(state.errorMessage, isNull);
    expect(state.commerce, isNotNull);
    expect(state.userName, 'Magnolia Valle');
    expect(state.rolId, 'ADMINISTRADOR');
    expect(state.hasCitySelected, true);
  });
}