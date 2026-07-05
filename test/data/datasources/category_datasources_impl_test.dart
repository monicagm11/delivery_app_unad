
import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/category_datasource.dart';
import 'package:delivery_app/data/datasources/category_datasource_impl.dart';
import 'package:delivery_app/data/models/category_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late CategoryDatasource datasource;
  late FakeFirebaseFirestore firestoresMock;
  ProviderContainer? container;

  setUp(() {
    firestoresMock = FakeFirebaseFirestore();
    datasource = CategoryDatasourceImpl(firestore: firestoresMock);
    registerFallbackValue(Mocks.categoryModelMock);
  });

  test('Verify provider of category datasource', () async {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(
          firestoresMock,
        ),
      ],
    );
    final datasourceInyected = container!.read(categoryDatasourceProvider);
    expect(datasourceInyected, isA<CategoryDatasourceImpl>());
    expect((datasourceInyected as CategoryDatasourceImpl).firestore,
        firestoresMock);
  });

  test('validate get empty list correctly Category', () async {
    List<CategoryModel> list = await datasource.getAll();
    expect(list, isEmpty);
  });

  test('validate create a new register correctly Category', () async {
    await datasource.create(Mocks.categoryModelMock);
    final result = await firestoresMock.collection('categories').get();
    expect(result.docs.length, 1);
    expect(result.docs[0]['name'], 'Hamburguesas');
  });

  test('validate get byCommerce correctly Category', () async {
    firestoresMock.collection('categories').doc('categoryCommerce1').set({
      'name': 'Hamburguesas',
      'description': 'Hamburguesa de carne',
      'status': 'ACTIVO',
      'commerce': 'commerce1'
    });

    firestoresMock.collection('categories').doc('categoryCommerce2').set({
      'name': 'Hamburguesas',
      'description': 'Hamburguesa de carne',
      'status': 'ACTIVO',
      'commerce': 'commerce2'
    });
    List<CategoryModel> list = await datasource.getByCommerce('commerce1');
    expect(list.length, 1);
    expect(list[0].id, 'categoryCommerce1');
  });

  test('validate update correctly Category', () async {
    firestoresMock.collection('categories').doc('categoryCommerce1').set({
      'name': 'Hamburguesas',
      'description': 'Hamburguesa de carne',
      'status': 'ACTIVO',
      'commerce': 'commerce1'
    });

    final resultPrevious = await firestoresMock
        .collection('categories')
        .doc('categoryCommerce1')
        .get();

    expect(resultPrevious['description'], 'Hamburguesa de carne');
    expect(resultPrevious['name'], 'Hamburguesas');

    await datasource.update(
        'categoryCommerce1',
        CategoryModel(
            id: '1',
            name: 'Hamburguesas dobles',
            description: 'Hamburguesa de carne con doble proteina',
            status: 'INACTIVO',
            commerce: 'commerce1'));
    final result = await firestoresMock
        .collection('categories')
        .doc('categoryCommerce1')
        .get();
    expect(result['description'], 'Hamburguesa de carne con doble proteina');
    expect(result['name'], 'Hamburguesas dobles');
  });

  test('validate get byId correctly Category', () async {
    firestoresMock.collection('categories').doc('categoryCommerce1').set({
      'name': 'Hamburguesas',
      'description': 'Hamburguesa de carne',
      'status': 'ACTIVO',
      'commerce': 'commerce1'
    });
    CategoryModel? value = await datasource.getById('categoryCommerce1');
    expect(value, isNotNull);
    expect(value!.description, 'Hamburguesa de carne');
  });

  test('validate delete byId correctly Category', () async {
    firestoresMock.collection('categories').doc('categoryCommerce1').set({
      'name': 'Hamburguesas',
      'description': 'Hamburguesa de carne',
      'status': 'ACTIVO',
      'commerce': 'commerce1'
    });
    await datasource.delete('categoryCommerce1');
    final result = await firestoresMock
        .collection('categories')
        .doc('categoryCommerce1')
        .get();
    expect(result.data(), isNull);
  });

  tearDownAll(() {
    container?.dispose();
  });
}
