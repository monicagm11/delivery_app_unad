import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of Category created correctly', () {
    CheckoutOrderModel model = Mocks.checkoutOrderModelMock;
    expect(model.userId, 'userId');
    expect(model.eventId, 'eventId');
    expect(model.userName, 'Marimar Luján');
    expect(model.commerce, 'ABC123DEF');
    expect(model.comments, 'Sin cebolla');
    expect(model.paymentMethod, 'cash');
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
    Map<String, dynamic> map = Mocks.mapCheckoutOrderModelMock;

    CheckoutOrderModel model = CheckoutOrderModel.fromMap(map);
    expect(model.userId, 'userId');
    expect(model.eventId, 'eventId');
    expect(model.userName, 'Marimar Luján');
    expect(model.commerce, 'ABC123DEF');
    expect(model.comments, 'Sin cebolla');
    expect(model.paymentMethod, 'cash');
    expect(model.urlImage,  'http://www.ejemplo.com/ticket.jpg');
    expect(model.change, '200000');
    expect(model.idDeliveryAssigned, 'TRE789HJ');
    expect(model.checkoutItems.length, 2);
    expect(model.total, 119000);
    expect(model.stageList.length, 2);
    expect(model.id, '123');
    expect(model.location,  'B1');
  });

  test('Verify properties of Map created from CheckoutOrderModel', () {
    CheckoutOrderModel model = Mocks.checkoutOrderModelMock;
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
}