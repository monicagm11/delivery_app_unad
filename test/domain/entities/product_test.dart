import 'package:delivery_app/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of Product created correctly', () {
    Product model = Mocks.productMock;
    expect(model.id, 'ABC123DEF');
    expect(model.name, 'Hamburguesa de carne');
    expect(model.priceBase, 50000);
    expect(model.percentageIva, 19);
    expect(model.valueIva, 9500);
    expect(model.totalPrice, 59500);
    expect(model.urlImage, 'http://www.ejemplo.com/ejemplo.jpg');
    expect(model.category, '1');
    expect(model.time, '15 min');
    expect(model.status, 'ACTIVO');
    expect(model.commerce, 'ABCDE123');
    expect(model.categoryName, 'Hamburguesas');
    expect(model.description, 'Hamburguesa de carne y queso americano');
  });

  test('Verify new properties before copyWith Product', () {
    Product mock = Mocks.productMock;
    Product model = mock.copyWith(time: '20 min');
    expect(model.id, 'ABC123DEF');
    expect(model.name, 'Hamburguesa de carne');
    expect(model.priceBase, 50000);
    expect(model.percentageIva, 19);
    expect(model.valueIva, 9500);
    expect(model.totalPrice, 59500);
    expect(model.urlImage, 'http://www.ejemplo.com/ejemplo.jpg');
    expect(model.category, '1');
    expect(model.time, '20 min');
    expect(model.status, 'ACTIVO');
    expect(model.commerce, 'ABCDE123');
    expect(model.categoryName, 'Hamburguesas');
    expect(model.description, 'Hamburguesa de carne y queso americano');
  });

  test('Verify properties of Map created from Product', () {
    Product model = Mocks.productMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['id'], 'ABC123DEF');
    expect(map['name'], 'Hamburguesa de carne');
    expect(map['priceBase'], 50000);
    expect(map['percentageIva'], 19);
    expect(map['valueIva'], 9500);
    expect(map['totalPrice'], 59500);
    expect(map['urlImage'], 'http://www.ejemplo.com/ejemplo.jpg');
    expect(map['category'], '1');
    expect(map['time'], '15 min');
    expect(map['status'], 'ACTIVO');
    expect(map['commerce'], 'ABCDE123');
    expect(map['categoryName'], 'Hamburguesas');
    expect(map['description'], 'Hamburguesa de carne y queso americano');

  });
}