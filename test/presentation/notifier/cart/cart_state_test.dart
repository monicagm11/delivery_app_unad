import 'package:delivery_app/presentation/notifier/cart/cart_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Verify properties of CartState created', () {
    CartState state = StateMocks.cartStateMock;
    expect(state.commerce, 'commerce1');
    expect(state.eventId, 'eventId');
    expect(state.eventName, 'Festival del perro caliente');
    expect(state.location, 'B1');
    expect(state.items.length, 1);
    expect(state.isEmpty, isFalse);
    expect(state.total, 119000);
    expect(state.totalItems, 2);
  });

  test('Verify properties of CartState copied', () {
    CartState statePrevious = StateMocks.cartStateMock;
    CartState state = statePrevious.copyWith(location: 'B2');
    expect(state.commerce, 'commerce1');
    expect(state.eventId, 'eventId');
    expect(state.eventName, 'Festival del perro caliente');
    expect(state.location, 'B2');
    expect(state.items.length, 1);
    expect(state.isEmpty, isFalse);
    expect(state.total, 119000);
    expect(state.totalItems, 2);
  });
}