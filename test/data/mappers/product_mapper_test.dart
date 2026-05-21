import 'package:delivery_app/data/mappers/product_mapper.dart';
import 'package:delivery_app/data/models/product_model.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final ProductMapper mapper;

  setUpAll(() {
    mapper = ProductMapper();
  });
  test('verify properties of convert product to productModel', () {
    Product entity = Mocks.productMock;
    ProductModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.id, 'ABC123DEF');
    expect(model?.name, 'Hamburguesa de carne');
    expect(model?.priceBase, 50000);
    expect(model?.percentageIva, 19);
    expect(model?.valueIva, 9500);
    expect(model?.totalPrice, 59500);
    expect(model?.urlImage, 'http://www.ejemplo.com/ejemplo.jpg');
    expect(model?.category, '1');
    expect(model?.time, '15 min');
    expect(model?.status, 'ACTIVO');
    expect(model?.commerce, 'ABCDE123');
    expect(model?.categoryName, 'Hamburguesas');
    expect(model?.description, 'Hamburguesa de carne y queso americano');
  });

  test('Verify return null when entity is null', () {
    Product? entity;
    ProductModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert productModel to product', () {
    ProductModel model = Mocks.productModelMock;
    Product? entity = mapper.toEntity(model);
    expect(entity?.id, 'ABC123DEF');
    expect(entity?.name, 'Hamburguesa de carne');
    expect(entity?.priceBase, 50000);
    expect(entity?.percentageIva, 19);
    expect(entity?.valueIva, 9500);
    expect(entity?.totalPrice, 59500);
    expect(entity?.urlImage, 'http://www.ejemplo.com/ejemplo.jpg');
    expect(entity?.category, '1');
    expect(entity?.time, '15 min');
    expect(entity?.status, 'ACTIVO');
    expect(entity?.commerce, 'ABCDE123');
    expect(entity?.categoryName, 'Hamburguesas');
    expect(entity?.description, 'Hamburguesa de carne y queso americano');
    
  });

  test('Verify return null when model is null', () {
    ProductModel? model;
    Product? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}