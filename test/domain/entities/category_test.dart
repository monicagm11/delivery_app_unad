import 'package:delivery_app/domain/entities/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of Category created correctly', () {
    Category model = Mocks.categoryMock;
    expect(model.id, '1');
    expect(model.name, 'Hamburguesas');
    expect(model.description, 'Hamburguesa de carne');
    expect(model.status, 'ACTIVO');
    expect(model.commerce, 'ABCDEFG123456');
  });

  test('Verify properties of Category created from map', () {
    Map<String, dynamic> map = Mocks.mapCategoryMock;

    Category model = Category.fromMap(map);
    expect(model.id, '1');
    expect(model.name, 'Hamburguesas');
    expect(model.description, 'Hamburguesa de carne');
    expect(model.status, 'ACTIVO');
    expect(model.commerce, 'ABCDEFG123456');
  });

  test('Verify properties of Map created from Category', () {
    Category model = Mocks.categoryMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['id'], '1');
    expect(map['name'], 'Hamburguesas');
    expect(map['description'], 'Hamburguesa de carne');
    expect(map['status'], 'ACTIVO');
    expect(map['commerce'], 'ABCDEFG123456');
  });
}