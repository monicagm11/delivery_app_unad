import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/checkout_order_datasource.dart';
import 'package:delivery_app/data/datasources/checkout_order_datasource_impl.dart';
import 'package:delivery_app/data/models/checkout_item_model.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late CheckoutOrderDatasource datasource;
  late FakeFirebaseFirestore firestoresMock;
  ProviderContainer? container;

  setUp(() {
    firestoresMock = FakeFirebaseFirestore();
    datasource = CheckoutOrderDatasourceImpl(firestore: firestoresMock);
    registerFallbackValue(Mocks.checkoutOrderModelMock);
  });

  test('Verify provider of checkout datasource', () async {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(
          firestoresMock,
        ),
      ],
    );
    final datasourceInyected = container!.read(checkoutOrderDatasourceProvider);
    expect(datasourceInyected, isA<CheckoutOrderDatasourceImpl>());
    expect((datasourceInyected as CheckoutOrderDatasourceImpl).firestore,
        firestoresMock);
  });

  test('validate get empty list correctly CheckoutOrder', () async {
    List<CheckoutOrderModel> list = await datasource.getAll();
    expect(list, isEmpty);
  });

  test('validate create a new register correctly CheckoutOrder', () async {
    await datasource.create(Mocks.checkoutOrderModelMock);
    final result = await firestoresMock.collection('checkout_orders').get();
    expect(result.docs.length, 1);
    expect(result.docs[0]['eventId'], 'eventId');
  });

  test('validate get byUser correctly CheckoutOrder', () async {
    firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .set({
      'id': '123',
      'userId': 'userId',
      'eventId': 'eventId',
      'urlImage': 'http://www.ejemplo.com/ticket.jpg',
      'change': '200000',
      'comments': 'Sin cebolla',
      'commerce': 'ABC123DEF',
      'paymentMethod': 'cash',
      'checkoutItems': [
        {
          'priceTotal': 119000.0,
          'valueIva': 19000.0,
          'percentageIva': 19.0,
          'priceBase': 100000.0,
          'idProduct': 'ABC123DEF',
          'nameProduct': 'Hamburguesa de carne',
          'count': 1
        },
        {
          'priceTotal': 11900.0,
          'valueIva': 1900.0,
          'percentageIva': 19.0,
          'priceBase': 10000.0,
          'idProduct': 'ABC1234EF',
          'nameProduct': 'Limonada natural',
          'count': 1
        }
      ],
      'stageList': [
        {
          'name': 'Pedido creado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        },
        {
          'name': 'Pedido confirmado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        }
      ],
      'total': 119000.0,
      'location': 'B1',
      'idDeliveryAssigned': 'TRE789HJ',
      'userName': 'Marimar Luján'
    });

    firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce2')
        .set({
      'userId': 'userId2',
      'eventId': 'eventId',
      'urlImage': 'http://www.ejemplo.com/ticket2.jpg',
      'change': '200000',
      'comments': 'Sin cebolla',
      'commerce': 'ABC123DEF',
      'paymentMethod': 'cash',
      'checkoutItems': [],
      'stageList': [],
      'total': 119000.0,
      'location': 'B1',
      'idDeliveryAssigned': 'TRE789HJ',
      'userName': 'Marimar Luján'
    });
    List<CheckoutOrderModel> list = await datasource.getByUser('userId2');
    expect(list.length, 1);
    expect(list[0].urlImage, 'http://www.ejemplo.com/ticket2.jpg');
  });

  test('validate get byEvent correctly CheckoutOrder', () async {
    firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .set({
      'id': '123',
      'userId': 'userId',
      'eventId': 'eventId',
      'urlImage': 'http://www.ejemplo.com/ticket.jpg',
      'change': '200000',
      'comments': 'Sin cebolla',
      'commerce': 'ABC123DEF',
      'paymentMethod': 'cash',
      'checkoutItems': [
        {
          'priceTotal': 119000.0,
          'valueIva': 19000.0,
          'percentageIva': 19.0,
          'priceBase': 100000.0,
          'idProduct': 'ABC123DEF',
          'nameProduct': 'Hamburguesa de carne',
          'count': 1
        },
        {
          'priceTotal': 11900.0,
          'valueIva': 1900.0,
          'percentageIva': 19.0,
          'priceBase': 10000.0,
          'idProduct': 'ABC1234EF',
          'nameProduct': 'Limonada natural',
          'count': 1
        }
      ],
      'stageList': [
        {
          'name': 'Pedido creado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        },
        {
          'name': 'Pedido confirmado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        }
      ],
      'total': 119000.0,
      'location': 'B1',
      'idDeliveryAssigned': 'TRE789HJ',
      'userName': 'Marimar Luján'
    });

    firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce2')
        .set({
      'userId': 'userId2',
      'eventId': 'eventId2',
      'urlImage': 'http://www.ejemplo.com/ticket2.jpg',
      'change': '200000',
      'comments': 'Sin cebolla',
      'commerce': 'ABC123DEF',
      'paymentMethod': 'cash',
      'checkoutItems': [],
      'stageList': [],
      'total': 119000.0,
      'location': 'B1',
      'idDeliveryAssigned': 'TRE789HJ',
      'userName': 'Marimar Luján'
    });
    List<CheckoutOrderModel> list = await datasource.getByEvent('eventId2');
    expect(list.length, 1);
    expect(list[0].urlImage, 'http://www.ejemplo.com/ticket2.jpg');
  });

  test('validate update correctly CheckoutOrder', () async {
    firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .set({
      'id': '123',
      'userId': 'userId',
      'eventId': 'eventId',
      'urlImage': 'http://www.ejemplo.com/ticket.jpg',
      'change': '200000',
      'comments': 'Sin cebolla',
      'commerce': 'ABC123DEF',
      'paymentMethod': 'cash',
      'checkoutItems': [
        {
          'priceTotal': 119000.0,
          'valueIva': 19000.0,
          'percentageIva': 19.0,
          'priceBase': 100000.0,
          'idProduct': 'ABC123DEF',
          'nameProduct': 'Hamburguesa de carne',
          'count': 1
        },
        {
          'priceTotal': 11900.0,
          'valueIva': 1900.0,
          'percentageIva': 19.0,
          'priceBase': 10000.0,
          'idProduct': 'ABC1234EF',
          'nameProduct': 'Limonada natural',
          'count': 1
        }
      ],
      'stageList': [
        {
          'name': 'Pedido creado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        },
        {
          'name': 'Pedido confirmado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        }
      ],
      'total': 119000.0,
      'location': 'B1',
      'idDeliveryAssigned': 'TRE789HJ',
      'userName': 'Marimar Luján'
    });

    final resultPrevious = await firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .get();

    expect(resultPrevious['change'], '200000');

    await datasource.update(
        'checkoutOrderCommerce1',
        CheckoutOrderModel(
            userId: 'userId',
            eventId: 'eventId',
            userName: 'Marimar Luján',
            commerce: 'ABC123DEF',
            comments: 'Sin cebolla',
            paymentMethod: 'cash',
            urlImage: 'http://www.ejemplo.com/ticket.jpg',
            change: '250000',
            idDeliveryAssigned: 'TRE789HJ',
            checkoutItems: [
              CheckoutItemModel(
                  priceTotal: 119000,
                  valueIva: 19000,
                  percentageIva: 19,
                  priceBase: 100000,
                  idProduct: 'ABC123DEF',
                  nameProduct: 'Hamburguesa de carne',
                  count: 1)
            ],
            total: 119000,
            stageList: [
              TrackingStageModel(
                  name: 'Pedido creado',
                  date: DateTime(2026, 4, 30),
                  completed: true),
              TrackingStageModel(
                  name: 'Pedido confirmado',
                  date: DateTime(2026, 4, 30),
                  completed: true)
            ],
            id: '123',
            location: 'B1'));
    final result = await firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .get();
    expect(result['change'], '250000');
  });

test('validate update delivery id correctly CheckoutOrder', () async {
    firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .set({
      'id': '123',
      'userId': 'userId',
      'eventId': 'eventId',
      'urlImage': 'http://www.ejemplo.com/ticket.jpg',
      'change': '200000',
      'comments': 'Sin cebolla',
      'commerce': 'ABC123DEF',
      'paymentMethod': 'cash',
      'checkoutItems': [
        {
          'priceTotal': 119000.0,
          'valueIva': 19000.0,
          'percentageIva': 19.0,
          'priceBase': 100000.0,
          'idProduct': 'ABC123DEF',
          'nameProduct': 'Hamburguesa de carne',
          'count': 1
        },
        {
          'priceTotal': 11900.0,
          'valueIva': 1900.0,
          'percentageIva': 19.0,
          'priceBase': 10000.0,
          'idProduct': 'ABC1234EF',
          'nameProduct': 'Limonada natural',
          'count': 1
        }
      ],
      'stageList': [
        {
          'name': 'Pedido creado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        },
        {
          'name': 'Pedido confirmado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        }
      ],
      'total': 119000.0,
      'location': 'B1',
      'idDeliveryAssigned':null,
      'userName': 'Marimar Luján'
    });

    final resultPrevious = await firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .get();

    expect(resultPrevious['idDeliveryAssigned'], isNull);

    await datasource.updateCheckoutStatus(
        'checkoutOrderCommerce1',
        {'idDeliveryAssigned': 'TRE789HJ',}
        );
    final result = await firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .get();
    expect(result['idDeliveryAssigned'], 'TRE789HJ');
  });

  test('validate get byId correctly CheckoutOrder', () async {
    firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .set({
      'id': '123',
      'userId': 'userId',
      'eventId': 'eventId',
      'urlImage': 'http://www.ejemplo.com/ticket.jpg',
      'change': '200000',
      'comments': 'Sin cebolla',
      'commerce': 'ABC123DEF',
      'paymentMethod': 'cash',
      'checkoutItems': [
        {
          'priceTotal': 119000.0,
          'valueIva': 19000.0,
          'percentageIva': 19.0,
          'priceBase': 100000.0,
          'idProduct': 'ABC123DEF',
          'nameProduct': 'Hamburguesa de carne',
          'count': 1
        },
        {
          'priceTotal': 11900.0,
          'valueIva': 1900.0,
          'percentageIva': 19.0,
          'priceBase': 10000.0,
          'idProduct': 'ABC1234EF',
          'nameProduct': 'Limonada natural',
          'count': 1
        }
      ],
      'stageList': [
        {
          'name': 'Pedido creado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        },
        {
          'name': 'Pedido confirmado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        }
      ],
      'total': 119000.0,
      'location': 'B1',
      'idDeliveryAssigned': 'TRE789HJ',
      'userName': 'Marimar Luján'
    });
    CheckoutOrderModel? value =
        await datasource.getById('checkoutOrderCommerce1');
    expect(value, isNotNull);
    expect(value!.eventId, 'eventId');
  });

  test('validate delete byId correctly CheckoutOrder', () async {
    firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .set({
      'id': '123',
      'userId': 'userId',
      'eventId': 'eventId',
      'urlImage': 'http://www.ejemplo.com/ticket.jpg',
      'change': '200000',
      'comments': 'Sin cebolla',
      'commerce': 'ABC123DEF',
      'paymentMethod': 'cash',
      'checkoutItems': [
        {
          'priceTotal': 119000.0,
          'valueIva': 19000.0,
          'percentageIva': 19.0,
          'priceBase': 100000.0,
          'idProduct': 'ABC123DEF',
          'nameProduct': 'Hamburguesa de carne',
          'count': 1
        },
        {
          'priceTotal': 11900.0,
          'valueIva': 1900.0,
          'percentageIva': 19.0,
          'priceBase': 10000.0,
          'idProduct': 'ABC1234EF',
          'nameProduct': 'Limonada natural',
          'count': 1
        }
      ],
      'stageList': [
        {
          'name': 'Pedido creado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        },
        {
          'name': 'Pedido confirmado',
          'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
          'completed': true
        }
      ],
      'total': 119000.0,
      'location': 'B1',
      'idDeliveryAssigned': 'TRE789HJ',
      'userName': 'Marimar Luján'
    });
    await datasource.delete('checkoutOrderCommerce1');
    final result = await firestoresMock
        .collection('checkout_orders')
        .doc('checkoutOrderCommerce1')
        .get();
    expect(result.data(), isNull);
  });

  tearDownAll(() {
    container?.dispose();
  });
}
