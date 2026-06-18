import 'package:delivery_app/presentation/notifier/checkout/checkout_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
   test('Validate properties of checkout state created', () {
    CheckoutState state = StateMocks.checkoutStateMock;
    expect(state.eventId, 'eventId');
    expect(state.isLoading, false);
    expect(state.eventName, 'Festival del perro caliente');
    expect(state.errorMessage, isNull);
    expect(state.isCheckoutCompleted, isFalse);
    expect(state.currentOrderId, '1234');
    expect(state.items.length, 1);
  });

  test('Validate properties of checkout initial state', () {
    CheckoutState state = CheckoutState.initial();
    expect(state.eventId, isNull);
    expect(state.isLoading, true);
    expect(state.eventName, isNull);
    expect(state.errorMessage, isNull);
    expect(state.isCheckoutCompleted, isFalse);
    expect(state.currentOrderId, isNull);
    expect(state.items.length, 0);
  });

  test('Validate properties of checkout state state copied', () {
    CheckoutState statePrevious = StateMocks.checkoutStateMock;
    CheckoutState state = statePrevious.copyWith(isLoading: true);
    expect(state.eventId, 'eventId');
    expect(state.isLoading, true);
    expect(state.eventName, 'Festival del perro caliente');
    expect(state.errorMessage, isNull);
    expect(state.isCheckoutCompleted, isFalse);
    expect(state.currentOrderId, '1234');
    expect(state.items.length, 1);
  });
}