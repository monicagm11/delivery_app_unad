import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/local_event_datasource.dart';
import 'package:delivery_app/data/datasources/local_event_datasource_impl.dart';
import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late LocalEventDatasource datasource;
  late FakeFirebaseFirestore firestoresMock;
  ProviderContainer? container;

  setUp(() {
    firestoresMock = FakeFirebaseFirestore();
    datasource = LocalEventDatasourceImpl(firestore: firestoresMock);
    registerFallbackValue(Mocks.localEventModelMock);
  });

  test('Verify provider of LocalEvent datasource', () async {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(
          firestoresMock,
        ),
      ],
    );
    final datasourceInyected = container!.read(localEventDatasourceProvider);
    expect(datasourceInyected, isA<LocalEventDatasourceImpl>());
    expect((datasourceInyected as LocalEventDatasourceImpl).firestore,
        firestoresMock);
  });

  test('validate get empty list correctly LocalEvent', () async {
    List<LocalEventModel> list = await datasource.getAll();
    expect(list, isEmpty);
  });

  test('validate create a new register correctly LocalEvent', () async {
    await datasource.create(Mocks.localEventModelMock);
    final result = await firestoresMock.collection('local_events').get();
    expect(result.docs.length, 1);
    expect(result.docs[0]['name'], 'Festival del perro caliente');
  });

  test('validate get byCommerce correctly LocalEvent', () async {
    firestoresMock.collection('local_events').doc('localEventCommerce1').set(Mocks.mapLocalEventModelMock);

    firestoresMock.collection('local_events').doc('localEventCommerce2').set({
      'name': 'Festival de la hamburguesa',
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
      'commerce': 'GHTYSB56',
      'locationClientType': 'numberedChair',
      'idGlobalEvent': '11'
    });
    List<LocalEventModel> list = await datasource.getByCommerce('GHTYSB56');
    expect(list.length, 1);
    expect(list[0].name, 'Festival de la hamburguesa');
  });

  test('validate get by city correctly LocalEvent', () async {
    firestoresMock.collection('local_events').doc('localEventCommerce1').set(Mocks.mapLocalEventModelMock);

    firestoresMock.collection('local_events').doc('localEventCommerce2').set({
      'name': 'Festival de la hamburguesa',
      'description': 'Festival del perro caliente en la plaza de la paz',
      'longitude': -74.789077,
      'latitude': 10.987877, 
      'radious': 100,
      'scheduleDate': '05/05/2026 12:00',
      'startDate': '05/05/2026 12:00',
      'endDate': '05/05/2026 18:00',
      'department': 'ATLANTICO',
      'city': 'PUERTO COLOMBIA',
      'status': 'PUBLICADO',
      'products': ['QWE1234', 'ASDF1234'],
      'commerce': 'ABCDE123',
      'locationClientType': 'numberedChair',
      'idGlobalEvent': '11'
    });
    List<LocalEventModel> list = await datasource.getActiveByCity('BARRANQUILLA','ATLANTICO');
    expect(list.length, 1);
    expect(list[0].name, 'Festival del perro caliente');
  });

  test('validate update correctly LocalEvent', () async {
    firestoresMock.collection('local_events').doc('localEventCommerce1').set(Mocks.mapLocalEventModelMock);

    final resultPrevious = await firestoresMock
        .collection('local_events')
        .doc('localEventCommerce1')
        .get();

    expect(resultPrevious['description'], 'Festival del perro caliente en la plaza de la paz');
    expect(resultPrevious['name'], 'Festival del perro caliente');

    await datasource.update(
        'localEventCommerce1',
        LocalEventModel(
      id: '1',
      name: 'Festival de la hamburguesa',
      description: 'Festival de la hamburguesa en el malecón del rio',
      longitude: -74.789077,
      latitude: 10.987877, 
      radious: 100,
      scheduleDate: '05/05/2026 12:00',
      startDate: '05/05/2026 12:00',
      endDate: '05/05/2026 18:00',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      productsIdList: [],
      commerce: 'ABCDE123',
      locationClientType: 'numberedChair',
      status: 'PUBLICADO'));
    final result = await firestoresMock
        .collection('local_events')
        .doc('localEventCommerce1')
        .get();
    expect(result['description'], 'Festival de la hamburguesa en el malecón del rio');
    expect(result['name'], 'Festival de la hamburguesa');
  });

  test('validate get byId correctly LocalEvent', () async {
    firestoresMock.collection('local_events').doc('localEventCommerce1').set(Mocks.mapLocalEventModelMock);
    LocalEventModel? value = await datasource.getById('localEventCommerce1');
    expect(value, isNotNull);
    expect(value!.description, 'Festival del perro caliente en la plaza de la paz');
  });

  test('validate delete byId correctly LocalEvent', () async {
    firestoresMock.collection('local_events').doc('localEventCommerce1').set(Mocks.mapLocalEventModelMock);
    await datasource.delete('localEventCommerce1');
    final result = await firestoresMock
        .collection('local_events')
        .doc('localEventCommerce1')
        .get();
    expect(result.data(), isNull);
  });

  tearDownAll(() {
    container?.dispose();
  });
}
