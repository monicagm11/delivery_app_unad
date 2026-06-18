import 'package:delivery_app/presentation/notifier/local_event/local_event_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of localEvent state created', () {
    LocalEventState state = StateMocks.localEventStateMock;
    expect(state.columns.length, 2);
    expect(state.departmentOptions.length, 1);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'LocalEvent');
    expect(state.productOptions.length, 1);
  });

  test('Validate properties of localEvent initial state', () {
    LocalEventState state = LocalEventState.initial([]);
    expect(state.columns.length, 0);
    expect(state.departmentOptions.length, 0);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'UNKNOWN');
    expect(state.productOptions, isEmpty);
  });

  test('Validate properties of localEvent state copied', () {
    LocalEventState statePrevious = StateMocks.localEventStateMock;
    LocalEventState state = statePrevious.copyWith(isLoading: true);
    expect(state.columns.length, 2);
    expect(state.isLoading, true);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'LocalEvent');
    expect(state.productOptions.length, 1);
  });
}