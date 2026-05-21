import 'package:delivery_app/domain/entities/cart_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of CartItem created correctly', () {
    CartItem model = CartItem(product: Mocks.productMock, quantity: 2);
    expect(model.product, isNotNull);
    expect(model.quantity, 2);
    expect(model.subtotalBase, 100000);
    expect(model.percentageIva, 19);
    expect(model.subtotalIva, 19000);
    expect(model.subtotal, 119000);
  });

  test('Verify properties of CartItem before copyWith', () {
    CartItem mock = CartItem(product: Mocks.productMock, quantity: 2);
    CartItem model = mock.copyWith(quantity: 1);
    expect(model.product, isNotNull);
    expect(model.quantity, 1);
    expect(model.subtotalBase, 50000);
    expect(model.percentageIva, 19);
    expect(model.subtotalIva, 9500);
    expect(model.subtotal, 59500);
  });
}