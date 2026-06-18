import 'package:delivery_app/presentation/notifier/create_request/create_request_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of createRequest state created', () {
    CreateRequestState state = StateMocks.createRequestStateMock;
    expect(state.globalEventOptions.length, 1);
    expect(state.columns.length, 2);
    expect(state.isLoading, isFalse);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'CreateRequest');
    expect(state.productOptions.length, 1);
    expect(state.globalEventAvailableOptions.length, 1);
    expect(state.data, isEmpty);
  });

  test('Validate properties of createRequest initial state', () {
    CreateRequestState state = CreateRequestState.initial([]);
    expect(state.globalEventOptions.length, 0);
    expect(state.columns.length, 0);
    expect(state.isLoading, isFalse);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'UNKNOWN');
    expect(state.productOptions.length, 0);
    expect(state.globalEventAvailableOptions.length, 0);
    expect(state.data, isEmpty);
  });

  test('Validate properties of createRequest state copied', () {
    CreateRequestState statePrevious = StateMocks.createRequestStateMock;
    CreateRequestState state = statePrevious.copyWith(isLoading: true);
    expect(state.globalEventOptions.length, 1);
    expect(state.columns.length, 2);
    expect(state.isLoading, isTrue);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'CreateRequest');
    expect(state.productOptions.length, 1);
    expect(state.globalEventAvailableOptions.length, 1);
    expect(state.data, isEmpty);
  });
}