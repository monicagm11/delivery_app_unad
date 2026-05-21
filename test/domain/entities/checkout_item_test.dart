import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of Category created correctly', () {
    CheckoutItem model = Mocks.checkoutItemMock;
    expect(model.count, 1);
    expect(model.priceBase, 100000);
    expect(model.percentageIva, 19);
    expect(model.valueIva, 19000);
    expect(model.priceTotal, 119000);
    expect(model.idProduct, 'ABC123DEF');
    expect(model.nameProduct,  'Hamburguesa de carne');
  });

  test('Verify properties of Category created from map', () {
    Map<String, dynamic> map = Mocks.mapCheckoutItemMock;

    CheckoutItem model = CheckoutItem.fromMap(map);
    expect(model.count, 1);
    expect(model.priceBase, 100000);
    expect(model.percentageIva, 19);
    expect(model.valueIva, 19000);
    expect(model.priceTotal, 119000);
    expect(model.idProduct, 'ABC123DEF');
    expect(model.nameProduct,  'Hamburguesa de carne');
  });

  test('Verify properties of Map created from CheckoutItem', () {
    CheckoutItem model = Mocks.checkoutItemMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['count'], 1);
    expect(map['priceBase'], 100000);
    expect(map['percentageIva'], 19);
    expect(map['valueIva'], 19000);
    expect(map['priceTotal'], 119000);
    expect(map['nameProduct'], 'Hamburguesa de carne');
    expect(map['idProduct'], 'ABC123DEF');
  });
}