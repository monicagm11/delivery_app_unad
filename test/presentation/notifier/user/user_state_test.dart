
import 'package:delivery_app/presentation/notifier/user/user_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of user state created', () {
    UserState state = StateMocks.userStateMock;
    expect(state.columns.length, 2);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.commerceOptions.length, 1);
    expect(state.functionConfig.functionName, 'User');
  });

  test('Validate properties of user initial state', () {
    UserState state = UserState.initial([]);
    expect(state.columns.length, 0);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'UNKNOWN');
    expect(state.commerceOptions.length, 0);
  });

  test('Validate properties of user state copied', () {
    UserState statePrevious = StateMocks.userStateMock;
    UserState state = statePrevious.copyWith(isLoading: true);
    expect(state.columns.length, 2);
    expect(state.isLoading, true);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'User');
    expect(state.commerceOptions.length, 1);
    expect(state.commerceOptions.length, 1);
  });
}