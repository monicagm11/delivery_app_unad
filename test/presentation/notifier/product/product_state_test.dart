import 'package:delivery_app/presentation/notifier/product/product_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of product state created', () {
    ProductState state = StateMocks.productStateMock;
    expect(state.columns.length, 2);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'Product');
    expect(state.categories.length, 1);
    expect(state.categoryOptions.length, 1);
  });

  test('Validate properties of product initial state', () {
    ProductState state = ProductState.initial([]);
    expect(state.columns.length, 0);
    expect(state.isLoading, false);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'UNKNOWN');
    expect(state.categories.length, 0);
    expect(state.categoryOptions.length, 0);
  });

  test('Validate properties of product state copied', () {
    ProductState statePrevious = StateMocks.productStateMock;
    ProductState state = statePrevious.copyWith(isLoading: true);
    expect(state.columns.length, 2);
    expect(state.isLoading, true);
    expect(state.data, isEmpty);
    expect(state.errorMessage, isNull);
    expect(state.showForm, isFalse);
    expect(state.functionConfig.functionName, 'Product');
    expect(state.categories.length, 1);
    expect(state.categoryOptions.length, 1);
  });
}