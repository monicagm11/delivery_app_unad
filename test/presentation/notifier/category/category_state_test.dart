import 'package:delivery_app/presentation/notifier/category/category_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of category state created', () {
    CategoryState state = StateMocks.categoryStateMock;
    expect(state.columns.length, 2);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'Category');
  });

  test('Validate properties of category initial state', () {
    CategoryState state = CategoryState.initial([]);
    expect(state.columns.length, 0);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'UNKNOWN');
  });

  test('Validate properties of category state copied', () {
    CategoryState statePrevious = StateMocks.categoryStateMock;
    CategoryState state = statePrevious.copyWith(isLoading: true);
    expect(state.columns.length, 2);
    expect(state.isLoading, true);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'Category');
  });
}