import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/data/models/checkout_item_model.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';

class Mocks {
  static CategoryModel categoryModelMock = CategoryModel(
        id: '1',
        name: 'Hamburguesas',
        description: 'Hamburguesa de carne',
        status: 'ACTIVO',
        commerce: 'ABCDEFG123456');

  static Map<String, dynamic> mapCategoryMock = {
        'id': '1',
        'name': 'Hamburguesas',
        'description': 'Hamburguesa de carne',
        'status': 'ACTIVO',
        'commerce': 'ABCDEFG123456',
      };

  static Category categoryMock = Category(
        id: '1',
        name: 'Hamburguesas',
        description: 'Hamburguesa de carne',
        status: 'ACTIVO',
        commerce: 'ABCDEFG123456');

  static CheckoutItemModel checkoutItemModelMock = CheckoutItemModel(
      priceTotal: 119000,
      valueIva: 19000,
      percentageIva: 19,
      priceBase: 100000,
      idProduct: 'ABC123DEF',
      nameProduct: 'Hamburguesa de carne',
      count: 1);
  
  static Map<String, dynamic> mapCheckoutItemMock = {
    'priceTotal': 119000,
    'valueIva': 19000,
    'percentageIva': 19,
    'priceBase': 100000,
    'idProduct': 'ABC123DEF',
    'nameProduct': 'Hamburguesa de carne',
    'count': 1,
  };

  static CheckoutItem checkoutItemMock = CheckoutItem(
      priceTotal: 119000,
      valueIva: 19000,
      percentageIva: 19,
      priceBase: 100000,
      idProduct: 'ABC123DEF',
      nameProduct: 'Hamburguesa de carne',
      count: 1);

  static CheckoutOrderModel checkoutOrderModelMock = CheckoutOrderModel(
      userId: 'userId',
      eventId: 'eventId',
      userName: 'Marimar Luján',
      commerce: 'ABC123DEF',
      comments: 'Sin cebolla',
      paymentMethod: 'cash',
      urlImage: 'http://www.ejemplo.com/ticket.jpg',
      change: '200000',
      idDeliveryAssigned: 'TRE789HJ',
      checkoutItems: [
        CheckoutItemModel(
            priceTotal: 119000,
            valueIva: 19000,
            percentageIva: 19,
            priceBase: 100000,
            idProduct: 'ABC123DEF',
            nameProduct: 'Hamburguesa de carne',
            count: 1),
        CheckoutItemModel(
            priceTotal: 11900,
            valueIva: 1900,
            percentageIva: 19,
            priceBase: 10000,
            idProduct: 'ABC1234EF',
            nameProduct: 'Limonada natural',
            count: 1)
      ],
      total: 119000,
      stageList: [
        TrackingStageModel(
            name: 'Pedido creado', date: DateTime(2026, 4, 30), completed: true),
        TrackingStageModel(
            name: 'Pedido confirmado', date: DateTime(2026, 4, 30), completed: true)
      ],
      id: '123',
      location: 'B1');

  static Map<String, dynamic> mapCheckoutOrderMock = {
    'id': '123',
    'userId': 'userId',
    'eventId': 'eventId',
    'urlImage': 'http://www.ejemplo.com/ticket.jpg',
    'change': '200000',
    'comments': 'Sin cebolla',
    'commerce': 'ABC123DEF',
    'paymentMethod': PaymentMethod.cash,
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
  };

  static Map<String, dynamic> mapCheckoutOrderModelMock = {
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
  };

  static CheckoutOrder checkoutOrderMock = CheckoutOrder(
      userId: 'userId',
      eventId: 'eventId',
      userName: 'Marimar Luján',
      commerce: 'ABC123DEF',
      comments: 'Sin cebolla',
      paymentMethod: PaymentMethod.cash,
      urlImage: 'http://www.ejemplo.com/ticket.jpg',
      change: '200000',
      idDeliveryAssigned: 'TRE789HJ',
      checkoutItems: [
        CheckoutItem(
            priceTotal: 119000,
            valueIva: 19000,
            percentageIva: 19,
            priceBase: 100000,
            idProduct: 'ABC123DEF',
            nameProduct: 'Hamburguesa de carne',
            count: 1),
        CheckoutItem(
            priceTotal: 11900,
            valueIva: 1900,
            percentageIva: 19,
            priceBase: 10000,
            idProduct: 'ABC1234EF',
            nameProduct: 'Limonada natural',
            count: 1)
      ],
      total: 119000,
      stageList: [
        TrackingStage(
            name: 'Pedido creado', date: DateTime(2026, 4, 30), completed: true),
        TrackingStage(
            name: 'Pedido confirmado', date: DateTime(2026, 4, 30), completed: true)
      ],
      id: '123',
      location: 'B1');

  static CommerceModel commerceModelMock = CommerceModel(
      id: 'ADGF234',
      name: 'Pizzeria MyG',
      document: '123456',
      identificationType: 'NIT',
      phone: '3001234567',
      address: 'CL 1 2-3',
      email: 'ejemplo@gmail.com',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      status: 'ACTIVO',
      contactName: 'Samanta Collazos',
      urlImage: 'http://www.ejemplo.com/ejemplo.jpg',
      urlImageQR: 'http://www.ejemplo.com/logo.jpg',
      fullDocument: 'NIT 123456');

  static Map<String, dynamic> mapCommerceMock = {
      'id': 'ADGF234',
      'name': 'Pizzeria MyG',
      'status': 'ACTIVO',
      'fullDocument': 'NIT 123456',
      'identificationType': 'NIT',
      'document': '123456',
      'phone': '3001234567',
      'address': 'CL 1 2-3',
      'email': 'ejemplo@gmail.com',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'contactName': 'Samanta Collazos',
      'urlImage': 'http://www.ejemplo.com/ejemplo.jpg',
      'urlImageQR': 'http://www.ejemplo.com/logo.jpg'
    };

  static Commerce commerceMock = Commerce(
      id: 'ADGF234',
      name: 'Pizzeria MyG',
      document: '123456',
      identificationType: 'NIT',
      phone: '3001234567',
      address: 'CL 1 2-3',
      email: 'ejemplo@gmail.com',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      status: 'ACTIVO',
      contactName: 'Samanta Collazos',
      urlImage: 'http://www.ejemplo.com/ejemplo.jpg',
      urlImageQR: 'http://www.ejemplo.com/logo.jpg',
      fullDocument: 'NIT 123456');

  static TrackingStageModel trackingStageModelMock = TrackingStageModel(
      name: 'Pedido creado', date: DateTime(2026, 4, 30), completed: true);

  static Map<String, dynamic> mapTrackingStageMock = {
    'name': 'Pedido creado',
    'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
    'completed': true
  };

  static TrackingStage trackingStageMock = TrackingStage(
      name: 'Pedido creado', date: DateTime(2026, 4, 30), completed: true);

  static List<Map<String, dynamic>> data = [
    {
      'id': 'ADGF234',
      'name': 'Pizzeria MyG',
      'status': 'ACTIVO',
      'fullDocument': 'NIT 123456',
      'identificationType': 'NIT',
      'document': '123456',
      'phone': '3001234567',
      'address': 'CL 1 2-3',
      'email': 'ejemplo@gmail.com',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'contactName': 'Samanta Collazos'
    },
    {
      'id': '2',
      'name': 'Hamburguesas Alameda',
      'status': 'INACTIVO',
      'fullDocument': 'CC 12309',
      'identificationType': 'CC',
      'document': '12309',
      'phone': '3019995522',
      'address': 'KR 9 8-7',
      'email': 'ejemplo2@gmail.com',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'contactName': 'Carlos Puello'
    },
  ];

}