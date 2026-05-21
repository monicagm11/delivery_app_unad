import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of Category created correctly', () {
    CheckoutOrder model = Mocks.checkoutOrderMock;
    expect(model.userId, 'userId');
    expect(model.eventId, 'eventId');
    expect(model.userName, 'Marimar Luján');
    expect(model.commerce, 'ABC123DEF');
    expect(model.comments, 'Sin cebolla');
    expect(model.paymentMethod, PaymentMethod.cash);
    expect(model.urlImage,  'http://www.ejemplo.com/ticket.jpg');
    expect(model.change, '200000');
    expect(model.idDeliveryAssigned, 'TRE789HJ');
    expect(model.checkoutItems.length, 2);
    expect(model.total, 119000);
    expect(model.stageList.length, 2);
    expect(model.id, '123');
    expect(model.location,  'B1');
  });

  test('Verify properties of Category created from map', () {
    Map<String, dynamic> map = Mocks.mapCheckoutOrderMock;

    CheckoutOrder model = CheckoutOrder.fromMap(map);
    expect(model.userId, 'userId');
    expect(model.eventId, 'eventId');
    expect(model.userName, 'Marimar Luján');
    expect(model.commerce, 'ABC123DEF');
    expect(model.comments, 'Sin cebolla');
    expect(model.paymentMethod, PaymentMethod.cash);
    expect(model.urlImage,  'http://www.ejemplo.com/ticket.jpg');
    expect(model.change, '200000');
    expect(model.idDeliveryAssigned, 'TRE789HJ');
    expect(model.checkoutItems.length, 2);
    expect(model.total, 119000);
    expect(model.stageList.length, 2);
    expect(model.id, '123');
    expect(model.location,  'B1');
  });

  test('Verify properties of Map created from CheckoutOrder', () {
    CheckoutOrder model = Mocks.checkoutOrderMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['userId'], 'userId');
    expect(map['eventId'], 'eventId');
    expect(map['userName'], 'Marimar Luján');
    expect(map['commerce'], 'ABC123DEF');
    expect(map['comments'], 'Sin cebolla');
    expect(map['paymentMethod'], 'cash');
    expect(map['urlImage'],  'http://www.ejemplo.com/ticket.jpg');
    expect(map['change'], '200000');
    expect(map['idDeliveryAssigned'], 'TRE789HJ');
    expect(map['checkoutItems'].length, 2);
    expect(map['total'], 119000);
    expect(map['stageList'].length, 2);
    expect(map['id'], '123');
    expect(map['location'],  'B1');
  });

  test('Verify new properties before copyWith CheckoutOrder', () {
    CheckoutOrder mock = Mocks.checkoutOrderMock;
    CheckoutOrder model = mock.copyWith(location: 'B3');
    expect(model.userId, 'userId');
    expect(model.eventId, 'eventId');
    expect(model.userName, 'Marimar Luján');
    expect(model.commerce, 'ABC123DEF');
    expect(model.comments, 'Sin cebolla');
    expect(model.paymentMethod, PaymentMethod.cash);
    expect(model.urlImage,  'http://www.ejemplo.com/ticket.jpg');
    expect(model.change, '200000');
    expect(model.idDeliveryAssigned, 'TRE789HJ');
    expect(model.checkoutItems.length, 2);
    expect(model.total, 119000);
    expect(model.stageList.length, 2);
    expect(model.id, '123');
    expect(model.location,  'B3');
  });

  test('Verify tracking stage added correctly', () {
    CheckoutOrder model = Mocks.checkoutOrderMock;
    model.addTrackingStage(Mocks.trackingStageMock);
    expect(model.stageList.length, 3);
  });

}