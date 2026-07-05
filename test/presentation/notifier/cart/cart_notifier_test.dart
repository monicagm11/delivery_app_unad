import 'package:delivery_app/presentation/notifier/cart/cart_notifier.dart';
import 'package:delivery_app/presentation/notifier/cart/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';

void main() {
  late CartNotifier notifier;
  late final ProviderContainer container;

  group('CartNotifier provider test', () {
    setUpAll(() {
      notifier = CartNotifier();

      container = ProviderContainer();
    });
    test('Verify provider of notifier', () async {
      final notifierState = container.read(cartNotifierProvider);
      expect(notifierState, isA<CartState>());
    });
  });

  group('CartNotifier test', () {
    setUp(() {
      notifier = CartNotifier();
    });

    test('Add first item correctly', () async {
      bool added = notifier.addItem(
          Mocks.productMock, 'eventId1', 'Nombre de evento', 'commerce1');
      expect(notifier.state.items.length, 1);
      expect(added, isTrue);
    });

    test('Add item with different event emit error', () async {
      notifier.addItem(
          Mocks.productMock, 'eventId1', 'Nombre de evento', 'commerce1');
      bool added = notifier.addItem(
          Mocks.productMock, 'eventId2', 'Nombre de evento', 'commerce2');
      expect(added, isFalse);
    });

    test('Update item when it exist in the cart', () async {
      notifier.addItem(
          Mocks.productMock, 'eventId1', 'Nombre de evento', 'commerce1');
      notifier.addItem(
          Mocks.productMock, 'eventId1', 'Nombre de evento', 'commerce1');
      expect(notifier.state.items.length, 1);
      expect(notifier.state.items[0].quantity, 2);
    });

    test('Update item quantity when it exist in the cart', () async {
      notifier.addItem(
          Mocks.productMock, 'eventId1', 'Nombre de evento', 'commerce1');
      notifier.updateQuantity('ABC123DEF', 3);
      expect(notifier.state.items.length, 1);
      expect(notifier.state.items[0].quantity, 3);
    });

    test('Remove item correctly', () async {
      notifier.removeItem('ABC123DEF');
      expect(notifier.state.items.length, 0);
    });

    test('clear state correctly', () async {
      notifier.clear();
      expect(notifier.state.items.length, 0);
    });

    test('update location correctly', () async {
      notifier.updateLocation('B1');
      expect(notifier.state.location, 'B1');
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
