import 'package:delivery_app/presentation/notifier/event_products/event_products_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of eventProducts state created', () {
    EventProductsState state = StateMocks.eventProductsStateMock;
    expect(state.categories.length, 1);
    expect(state.isLoading, false);
    expect(state.allProducts.length, 1);
    expect(state.errorMessage, isNull);
    expect(state.filteredProducts.length, 1);
    expect(state.commerceId, 'commerceId');
    expect(state.selectedCategoryId, '1');
  });

  test('Validate properties of eventProducts initial state', () {
    EventProductsState state = EventProductsState.initial();
    expect(state.categories.length, 0);
    expect(state.isLoading, true);
    expect(state.allProducts.length, 0);
    expect(state.errorMessage, isNull);
    expect(state.filteredProducts.length, 0);
    expect(state.commerceId, isNull);
    expect(state.selectedCategoryId, isNull);
  });

  test('Validate properties of eventProducts state copied', () {
    EventProductsState statePrevious = StateMocks.eventProductsStateMock;
    EventProductsState state = statePrevious.copyWith(isLoading: true);
    expect(state.categories.length, 1);
    expect(state.isLoading, true);
    expect(state.allProducts.length, 1);
    expect(state.errorMessage, isNull);
    expect(state.filteredProducts.length, 1);
    expect(state.commerceId, 'commerceId');
    expect(state.selectedCategoryId, '1');
  });
}