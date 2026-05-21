import 'package:delivery_app/data/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of Category created correctly', () {
    CategoryModel model = Mocks.categoryModelMock;
    expect(model.id, '1');
    expect(model.name, 'Hamburguesas');
    expect(model.description, 'Hamburguesa de carne');
    expect(model.status, 'ACTIVO');
    expect(model.commerce, 'ABCDEFG123456');
  });

  test('Verify properties of Category created from map', () {
    Map<String, dynamic> map = Mocks.mapCategoryMock;

    CategoryModel model = CategoryModel.fromMap(map);
    expect(model.id, '1');
    expect(model.name, 'Hamburguesas');
    expect(model.description, 'Hamburguesa de carne');
    expect(model.status, 'ACTIVO');
    expect(model.commerce, 'ABCDEFG123456');
  });

  test('Verify properties of Map created from CategoryModel', () {
    CategoryModel model = Mocks.categoryModelMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['id'], '1');
    expect(map['name'], 'Hamburguesas');
    expect(map['description'], 'Hamburguesa de carne');
    expect(map['status'], 'ACTIVO');
    expect(map['commerce'], 'ABCDEFG123456');
  });
}