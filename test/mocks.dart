import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/data/models/checkout_item_model.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:delivery_app/data/models/product_model.dart';
import 'package:delivery_app/data/models/user_model.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/domain/entities/user.dart';

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

  static GlobalEvent globalEventMock = GlobalEvent(
      id: '1',
      name: 'Festival del perro caliente',
      description: 'Festival del perro caliente en la plaza de la paz',
      longitude: -74.789077,
      latitude: 10.987877, 
      radious: 100,
      scheduleDate: '05/05/2026 12:00',
      startDate: '05/05/2026 12:00',
      endDate: '05/05/2026 18:00',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      status: 'PUBLICADO');

  static Map<String, dynamic> mapGlobalEventModelMock = {
      'id': '1',
      'name': 'Festival del perro caliente',
      'description': 'Festival del perro caliente en la plaza de la paz',
      'longitude': -74.789077,
      'latitude': 10.987877, 
      'radious': 100,
      'scheduleDate': '05/05/2026 12:00',
      'startDate': '05/05/2026 12:00',
      'endDate': '05/05/2026 18:00',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'status': 'PUBLICADO'};

  static GlobalEventModel globalEventModelMock = GlobalEventModel(
      id: '1',
      name: 'Festival del perro caliente',
      description: 'Festival del perro caliente en la plaza de la paz',
      longitude: -74.789077,
      latitude: 10.987877, 
      radious: 100,
      scheduleDate: '05/05/2026 12:00',
      startDate: '05/05/2026 12:00',
      endDate: '05/05/2026 18:00',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      status: 'PUBLICADO');

  static Map<String, dynamic> mapLocalEventModelMock = {
      'id': '1',
      'name': 'Festival del perro caliente',
      'description': 'Festival del perro caliente en la plaza de la paz',
      'longitude': -74.789077,
      'latitude': 10.987877, 
      'radious': 100,
      'scheduleDate': '05/05/2026 12:00',
      'startDate': '05/05/2026 12:00',
      'endDate': '05/05/2026 18:00',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'status': 'PUBLICADO',
      'products': ['QWE1234', 'ASDF1234'],
      'commerce': 'ABCDE123',
      'locationClientType': 'numberedChair',
      'idGlobalEvent': '11'};

  static LocalEvent localEventMock = LocalEvent(
      id: '1',
      name: 'Festival del perro caliente',
      description: 'Festival del perro caliente en la plaza de la paz',
      longitude: -74.789077,
      latitude: 10.987877, 
      radious: 100,
      scheduleDate: '05/05/2026 12:00',
      startDate: '05/05/2026 12:00',
      endDate: '05/05/2026 18:00',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      status: 'PUBLICADO',
      productsIdList: ['QWE1234', 'ASDF1234'],
      commerce: 'ABCDE123',
      locationClientType: 'numberedChair',
      idGlobalEvent: '11');

  static LocalEventModel localEventModelMock = LocalEventModel(
      id: '1',
      name: 'Festival del perro caliente',
      description: 'Festival del perro caliente en la plaza de la paz',
      longitude: -74.789077,
      latitude: 10.987877, 
      radious: 100,
      scheduleDate: '05/05/2026 12:00',
      startDate: '05/05/2026 12:00',
      endDate: '05/05/2026 18:00',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      status: 'PUBLICADO',
      productsIdList: ['QWE1234', 'ASDF1234'],
      commerce: 'ABCDE123',
      locationClientType: 'numberedChair',
      idGlobalEvent: '11');

  static Product productMock = Product(
      id: 'ABC123DEF',
      name: 'Hamburguesa de carne',
      priceBase: 50000,
      percentageIva: 19,
      valueIva: 9500,
      totalPrice: 59500,
      urlImage: 'http://www.ejemplo.com/ejemplo.jpg',
      category: '1',
      time: '15 min',
      status: 'ACTIVO',
      commerce: 'ABCDE123',
      description: 'Hamburguesa de carne y queso americano',
      categoryName: 'Hamburguesas');

  static Map<String, dynamic> mapProductMock = {
    'id': 'ABC123DEF',
    'name': 'Hamburguesa de carne',
    'priceBase': 50000,
    'percentageIva': 19,
    'valueIva': 9500,
    'totalPrice': 59500,
    'urlImage': 'http://www.ejemplo.com/ejemplo.jpg',
    'category': '1',
    'time': '15 min',
    'status': 'ACTIVO',
    'commerce': 'ABCDE123',
    'description': 'Hamburguesa de carne y queso americano',
    'categoryName': 'Hamburguesas'
  };

  static ProductModel productModelMock = ProductModel(
      id: 'ABC123DEF',
      name: 'Hamburguesa de carne',
      priceBase: 50000,
      percentageIva: 19,
      valueIva: 9500,
      totalPrice: 59500,
      urlImage: 'http://www.ejemplo.com/ejemplo.jpg',
      category: '1',
      time: '15 min',
      status: 'ACTIVO',
      commerce: 'ABCDE123',
      description: 'Hamburguesa de carne y queso americano',
      categoryName: 'Hamburguesas');

  static TrackingStageModel trackingStageModelMock = TrackingStageModel(
      name: 'Pedido creado', 
      date: DateTime(2026, 4, 30), 
      completed: true);

  static Map<String, dynamic> mapTrackingStageMock = {
    'name': 'Pedido creado',
    'date': Timestamp.fromDate(DateTime.utc(2026, 4, 30)),
    'completed': true
  };

  static TrackingStage trackingStageMock = TrackingStage(
      name: 'Pedido creado', 
      date: DateTime(2026, 4, 30), 
      completed: true);

  static User userMock = User(
      id: 'POIU908',
      name: 'Maria',
      lastname: 'Suarez',
      fullname: 'Maria Suarez',
      document: '123456789',
      identificationType: 'CC',
      fullDocument: 'CC 123456789',
      phone: '3000010203',
      email: 'mariasuarez@ejemplo.com',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      address: 'CL 11 11 11',
      commerce: 'ABCDE123',
      occupation: 'Administrador general',
      currentEventId: '1',
      token: 'nfiergbseifgre3y443rsb73ehsb',
      userId: 'POIU908',
      status: 'ACTIVO',
      rol: 'ADMINISTRADOR');

  static Map<String, dynamic> mapUserMock = {
    'id': 'POIU908',
    'name': 'Maria',
    'lastname': 'Suarez',
    'fullname': 'Maria Suarez',
    'document': '123456789',
    'identificationType': 'CC',
    'fullDocument': 'CC 123456789',
    'phone': '3000010203',
    'email': 'mariasuarez@ejemplo.com',
    'department': 'ATLANTICO',
    'city': 'BARRANQUILLA',
    'address': 'CL 11 11 11',
    'commerce': 'ABCDE123',
    'occupation': 'Administrador general',
    'currentEventId': '1',
    'token': 'nfiergbseifgre3y443rsb73ehsb',
    'userId': 'POIU908',
    'status': 'ACTIVO',
    'rol': 'ADMINISTRADOR'
  };

  static UserModel userModelMock = UserModel(
      id: 'POIU908',
      name: 'Maria',
      lastname: 'Suarez',
      fullname: 'Maria Suarez',
      document: '123456789',
      identificationType: 'CC',
      fullDocument: 'CC 123456789',
      phone: '3000010203',
      email: 'mariasuarez@ejemplo.com',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      address: 'CL 11 11 11',
      commerce: 'ABCDE123',
      occupation: 'Administrador general',
      currentEventId: '1',
      token: 'nfiergbseifgre3y443rsb73ehsb',
      userId: 'POIU908',
      status: 'ACTIVO',
      rol: 'ADMINISTRADOR');

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