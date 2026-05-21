import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/data/models/checkout_item_model.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/entities/checkout_item.dart';

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

  static List<Map<String, dynamic>> data = [
    {
      "id": "1",
      "name": "Pizzeria MyG",
      "status": "ACTIVO",
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
      "id": "2",
      "name": "Hamburguesas Alameda",
      "status": "INACTIVO",
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