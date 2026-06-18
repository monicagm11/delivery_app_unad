import 'package:delivery_app/data/mappers/checkout_order_mapper.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final CheckoutOrderMapper mapper;

  setUpAll(() {
    mapper = CheckoutOrderMapper();
  });
  test('verify properties of convert CheckoutOrder to CheckoutOrderModel', () {
    CheckoutOrder entity = Mocks.checkoutOrderMock;
    CheckoutOrderModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.userId, 'userId');
    expect(model?.eventId, 'eventId');
    expect(model?.userName, 'Marimar Luján');
    expect(model?.commerce, 'ABC123DEF');
    expect(model?.comments, 'Sin cebolla');
    expect(model?.paymentMethod, 'cash');
    expect(model?.urlImage,  'http://www.ejemplo.com/ticket.jpg');
    expect(model?.change, '200000');
    expect(model?.idDeliveryAssigned, 'TRE789HJ');
    expect(model?.checkoutItems.length, 2);
    expect(model?.total, 119000);
    expect(model?.stageList.length, 2);
    expect(model?.id, '123');
    expect(model?.location,  'B1');
  });

  test('Verify return null when entity is null', () {
    CheckoutOrder? entity;
    CheckoutOrderModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert CheckoutOrderModel to CheckoutOrder', () {
    CheckoutOrderModel model = Mocks.checkoutOrderModelMock;
    CheckoutOrder? entity = mapper.toEntity(model);
    expect(entity, isNotNull);
    expect(entity?.userId, 'userId');
    expect(entity?.eventId, 'eventId');
    expect(entity?.userName, 'Marimar Luján');
    expect(entity?.commerce, 'ABC123DEF');
    expect(entity?.comments, 'Sin cebolla');
    expect(entity?.paymentMethod, PaymentMethod.cash);
    expect(entity?.urlImage,  'http://www.ejemplo.com/ticket.jpg');
    expect(entity?.change, '200000');
    expect(entity?.idDeliveryAssigned, 'TRE789HJ');
    expect(entity?.checkoutItems.length, 2);
    expect(entity?.total, 119000);
    expect(entity?.stageList.length, 2);
    expect(entity?.id, '123');
    expect(entity?.location,  'B1');
  });

  test('verify payment method default of convert CheckoutOrderModel to CheckoutOrder', () {
    CheckoutOrderModel model = CheckoutOrderModel(
      userId: 'userId',
      eventId: 'eventId',
      userName: 'Marimar Luján',
      commerce: 'ABC123DEF',
      comments: 'Sin cebolla',
      paymentMethod: '',
      urlImage: 'http://www.ejemplo.com/ticket.jpg',
      change: '200000',
      idDeliveryAssigned: 'TRE789HJ',
      checkoutItems: [
      ],
      total: 119000,
      stageList: [
      ],
      id: '123',
      location: 'B1');
      
    CheckoutOrder? entity = mapper.toEntity(model);
    expect(entity?.paymentMethod, PaymentMethod.cash);
  });

  test('Verify return null when model is null', () {
    CheckoutOrderModel? model;
    CheckoutOrder? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}