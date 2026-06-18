
import 'package:delivery_app/presentation/notifier/session/session_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of session state created', () {
    SessionState state = StateMocks.sessionStateMock;
    expect(state.user, isNotNull);
    expect(state.rolConfig, isNotNull);
    expect(state.commerce, isNotNull);
    expect(state.userName, 'Magnolia Valle');
    expect(state.rolId, 'ADMINISTRADOR');
  });

  test('Validate properties of session state copied', () {
    SessionState statePrevious = StateMocks.sessionStateMock;
    SessionState state = statePrevious.copyWith(rolId: 'LOGISTICO');
    expect(state.user, isNotNull);
    expect(state.rolConfig, isNotNull);
    expect(state.commerce, isNotNull);
    expect(state.userName, 'Magnolia Valle');
    expect(state.rolId, 'LOGISTICO');
  });
}