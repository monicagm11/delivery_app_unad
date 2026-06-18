import 'package:delivery_app/presentation/notifier/commerce/commerce_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of commerce state created', () {
    CommerceState state = StateMocks.commerceStateMock;
    expect(state.columns.length, 2);
    expect(state.departmentOptions.length, 1);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'Commerce');
  });

  test('Validate properties of commerce initial state', () {
    CommerceState state = CommerceState.initial([]);
    expect(state.columns.length, 0);
    expect(state.departmentOptions.length, 0);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'UNKNOWN');
  });

  test('Validate properties of commerce state copied', () {
    CommerceState statePrevious = StateMocks.commerceStateMock;
    CommerceState state = statePrevious.copyWith(isLoading: true);
    expect(state.columns.length, 2);
    expect(state.isLoading, true);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'Commerce');
  });
}