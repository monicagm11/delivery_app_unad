import 'package:delivery_app/presentation/notifier/global_event/global_event_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of globalEvent state created', () {
    GlobalEventState state = StateMocks.globalEventStateMock;
    expect(state.columns.length, 2);
    expect(state.departmentOptions.length, 1);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'GlobalEvent');
  });

  test('Validate properties of globalEvent initial state', () {
    GlobalEventState state = GlobalEventState.initial([]);
    expect(state.columns.length, 0);
    expect(state.departmentOptions.length, 0);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'UNKNOWN');
  });

  test('Validate properties of globalEvent state copied', () {
    GlobalEventState statePrevious = StateMocks.globalEventStateMock;
    GlobalEventState state = statePrevious.copyWith(isLoading: true);
    expect(state.columns.length, 2);
    expect(state.isLoading, true);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'GlobalEvent');
  });
}