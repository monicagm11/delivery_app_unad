import 'package:delivery_app/data/mappers/checkout_item_mapper.dart';
import 'package:delivery_app/data/models/checkout_item_model.dart';
import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final CheckoutItemMapper mapper;

  setUpAll(() {
    mapper = CheckoutItemMapper();
  });
  test('verify properties of convert CheckoutItem to CheckoutItemModel', () {
    CheckoutItem entity = Mocks.checkoutItemMock;
    CheckoutItemModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.count, 1);
    expect(model?.priceBase, 100000);
    expect(model?.percentageIva, 19);
    expect(model?.valueIva, 19000);
    expect(model?.priceTotal, 119000);
    expect(model?.idProduct, 'ABC123DEF');
    expect(model?.nameProduct,  'Hamburguesa de carne');
  });

  test('Verify return null when entity is null', () {
    CheckoutItem? entity;
    CheckoutItemModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert CheckoutItemModel to CheckoutItem', () {
    CheckoutItemModel model = Mocks.checkoutItemModelMock;
    CheckoutItem? entity = mapper.toEntity(model);
    expect(entity, isNotNull);
    expect(entity?.count, 1);
    expect(entity?.priceBase, 100000);
    expect(entity?.percentageIva, 19);
    expect(entity?.valueIva, 19000);
    expect(entity?.priceTotal, 119000);
    expect(entity?.idProduct, 'ABC123DEF');
    expect(entity?.nameProduct,  'Hamburguesa de carne');
  });

  test('Verify return null when model is null', () {
    CheckoutItemModel? model;
    CheckoutItem? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}