import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/product_datasource.dart';
import 'package:delivery_app/data/datasources/product_datasource_impl.dart';
import 'package:delivery_app/data/models/product_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late ProductDatasource datasource;
  late FakeFirebaseFirestore firestoresMock;
  ProviderContainer? container;

  setUp(() {
    firestoresMock = FakeFirebaseFirestore();
    datasource = ProductDatasourceImpl(firestore: firestoresMock);
    registerFallbackValue(Mocks.productModelMock);
  });

  test('Verify provider of products datasource', () async {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(
          firestoresMock,
        ),
      ],
    );
    final datasourceInyected = container!.read(productDatasourceProvider);
    expect(datasourceInyected, isA<ProductDatasourceImpl>());
    expect((datasourceInyected as ProductDatasourceImpl).firestore,
        firestoresMock);
  });

  test('validate create a new register correctly Product', () async {
    await datasource.create(Mocks.productModelMock);
    final result = await firestoresMock.collection('products').get();
    expect(result.docs.length, 1);
    expect(result.docs[0]['name'], 'Hamburguesa de carne');
  });

  test('validate get byCommerce correctly Product', () async {
    firestoresMock.collection('products').doc('productCommerce1').set({
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
      'commerce': 'commerce1',
      'description': 'Hamburguesa de carne y queso americano',
      'categoryName': 'Hamburguesas'
    });

    firestoresMock.collection('products').doc('productCommerce2').set({
      'id': 'TRSF225',
      'name': 'Hamburguesa de pollo',
      'priceBase': 50000,
      'percentageIva': 19,
      'valueIva': 9500,
      'totalPrice': 59500,
      'urlImage': 'http://www.ejemplo.com/ejemplo.jpg',
      'category': '1',
      'time': '15 min',
      'status': 'ACTIVO',
      'commerce': 'commerce2',
      'description': 'Hamburguesa de carne y queso americano',
      'categoryName': 'Hamburguesas'
    });
    List<ProductModel> list = await datasource.getByCommerce('commerce1');
    expect(list.length, 1);
    expect(list[0].name, 'Hamburguesa de carne');
  });

  test('validate update correctly Product', () async {
    firestoresMock.collection('products').doc('productCommerce1').set({
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
    });

    final resultPrevious = await firestoresMock
        .collection('products')
        .doc('productCommerce1')
        .get();

    expect(resultPrevious['description'],
        'Hamburguesa de carne y queso americano');
    expect(resultPrevious['name'], 'Hamburguesa de carne');

    await datasource.update(
        'productCommerce1',
        ProductModel(
            id: 'ABC123DEF',
            name: 'Hamburguesa doble carne',
            priceBase: 50000,
            percentageIva: 19,
            valueIva: 9500,
            totalPrice: 59500,
            urlImage: 'http://www.ejemplo.com/ejemplo.jpg',
            category: '1',
            time: '15 min',
            status: 'ACTIVO',
            commerce: 'ABCDE123',
            description:
                'Hamburguesa de carne y queso americano con doble proteina',
            categoryName: 'Hamburguesas'));
    final result = await firestoresMock
        .collection('products')
        .doc('productCommerce1')
        .get();
    expect(result['description'], 'Hamburguesa de carne y queso americano con doble proteina');
    expect(result['name'], 'Hamburguesa doble carne');
  });

  test('validate get byId correctly Product', () async {
    firestoresMock.collection('products').doc('productCommerce1').set({
      'name': 'Hamburguesas',
      'description': 'Hamburguesa de carne',
      'status': 'ACTIVO',
      'commerce': 'commerce1'
    });
    ProductModel? value = await datasource.getById('productCommerce1');
    expect(value, isNotNull);
    expect(value!.description, 'Hamburguesa de carne');
  });

  test('validate delete byId correctly Product', () async {
    firestoresMock.collection('products').doc('productCommerce1').set({
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
    });
    await datasource.delete('productCommerce1');
    final result = await firestoresMock
        .collection('products')
        .doc('productCommerce1')
        .get();
    expect(result.data(), isNull);
  });

  tearDownAll(() {
    container?.dispose();
  });
}
