import 'package:delivery_app/data/mappers/category_mapper.dart';
import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final CategoryMapper mapper;

  setUpAll(() {
    mapper = CategoryMapper();
  });
  test('verify properties of convert category to categoryModel', () {
    Category entity = Mocks.categoryMock;
    CategoryModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.id, '1');
    expect(model?.name, 'Hamburguesas');
    expect(model?.description, 'Hamburguesa de carne');
    expect(model?.status, 'ACTIVO');
    expect(model?.commerce, 'ABCDEFG123456');
  });

  test('Verify return null when entity is null', () {
    Category? entity;
    CategoryModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert categoryModel to category', () {
    CategoryModel model = Mocks.categoryModelMock;
    Category? entity = mapper.toEntity(model);
    expect(entity, isNotNull);
    expect(entity?.id, '1');
    expect(entity?.name, 'Hamburguesas');
    expect(entity?.description, 'Hamburguesa de carne');
    expect(entity?.status, 'ACTIVO');
    expect(entity?.commerce, 'ABCDEFG123456');
  });

  test('Verify return null when model is null', () {
    CategoryModel? model;
    Category? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}