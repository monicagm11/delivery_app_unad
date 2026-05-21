import 'package:delivery_app/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of Product created correctly', () {
    ProductModel model = Mocks.productModelMock;
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

  test('Verify properties of Product created from map', () {
    Map<String, dynamic> map = Mocks.mapProductMock;

    ProductModel model = ProductModel.fromMap(map);
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

  test('Verify properties of Map created from ProductModel', () {
    ProductModel model = Mocks.productModelMock;
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