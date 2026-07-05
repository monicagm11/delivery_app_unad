import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/commerce_datasource.dart';
import 'package:delivery_app/data/datasources/commerce_datasource_impl.dart';
import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late CommerceDatasource datasource;
  late FakeFirebaseFirestore firestoresMock;
  ProviderContainer? container;

  setUp(() {
    firestoresMock = FakeFirebaseFirestore();
    datasource = CommerceDatasourceImpl(firestore: firestoresMock);
    registerFallbackValue(Mocks.commerceModelMock);
  });

  test('Verify provider of commerce datasource', () async {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(
          firestoresMock,
        ),
      ],
    );
    final datasourceInyected = container!.read(commerceDatasourceProvider);
    expect(datasourceInyected, isA<CommerceDatasourceImpl>());
    expect((datasourceInyected as CommerceDatasourceImpl).firestore,
        firestoresMock);
  });

  test('validate get empty list correctly Commerce', () async {
    List<CommerceModel> list = await datasource.getAll();
    expect(list, isEmpty);
  });

  test('validate create a new register correctly Commerce', () async {
    await datasource.create(Mocks.commerceModelMock);
    final result = await firestoresMock.collection('commerces').get();
    expect(result.docs.length, 1);
    expect(result.docs[0]['name'], 'Pizzeria MyG');
  });

  test('validate update correctly Commerce', () async {
    firestoresMock
        .collection('commerces')
        .doc('commerce1')
        .set(Mocks.mapCommerceMock);

    final resultPrevious =
        await firestoresMock.collection('commerces').doc('commerce1').get();

    expect(resultPrevious['contactName'], 'Samanta Collazos');
    expect(resultPrevious['name'], 'Pizzeria MyG');

    await datasource.update(
        'commerce1',
        CommerceModel(
            id: 'ADGF234',
            name: 'Pizzeria MyG SAS',
            document: '123456',
            identificationType: 'NIT',
            phone: '3001234567',
            address: 'CL 1 2-3',
            email: 'ejemplo@gmail.com',
            department: 'ATLANTICO',
            city: 'BARRANQUILLA',
            status: 'ACTIVO',
            contactName: 'Claudia Macias',
            urlImage: 'http://www.ejemplo.com/ejemplo.jpg',
            urlImageQR: 'http://www.ejemplo.com/logo.jpg',
            fullDocument: 'NIT 123456'));
    final result =
        await firestoresMock.collection('commerces').doc('commerce1').get();
    expect(result['contactName'], 'Claudia Macias');
    expect(result['name'], 'Pizzeria MyG SAS');
  });

  test('validate get byId correctly Commerce', () async {
    firestoresMock.collection('commerces').doc('commerce1').set({
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
    });
    CommerceModel? value = await datasource.getById('commerce1');
    expect(value, isNotNull);
    expect(value!.name, 'Pizzeria MyG');
  });

  test('validate delete byId correctly Commerce', () async {
    firestoresMock.collection('commerces').doc('commerce1').set({
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
    });
    await datasource.delete('commerce1');
    final result =
        await firestoresMock.collection('commerces').doc('commerce1').get();
    expect(result.data(), isNull);
  });

  tearDownAll(() {
    container?.dispose();
  });
}
