import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/global_event_datasource.dart';
import 'package:delivery_app/data/datasources/global_event_datasource_impl.dart';
import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late GlobalEventDatasource datasource;
  late FakeFirebaseFirestore firestoresMock;
  ProviderContainer? container;

  setUp(() {
    firestoresMock = FakeFirebaseFirestore();
    datasource = GlobalEventDatasourceImpl(firestore: firestoresMock);
    registerFallbackValue(Mocks.globalEventModelMock);
  });

  test('Verify provider of datasource', () async {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(
          firestoresMock,
        ),
      ],
    );
    final datasourceInyected = container!.read(globalEventDatasourceProvider);
    expect(datasourceInyected, isA<GlobalEventDatasourceImpl>());
    expect((datasourceInyected as GlobalEventDatasourceImpl).firestore,
        firestoresMock);
  });

  test('validate get empty list correctly GlobalEvent', () async {
    List<GlobalEventModel> list = await datasource.getAll();
    expect(list, isEmpty);
  });

  test('validate create a new register correctly GlobalEvent', () async {
    await datasource.create(Mocks.globalEventModelMock);
    final result = await firestoresMock.collection('global_events').get();
    expect(result.docs.length, 1);
    expect(result.docs[0]['name'], 'Festival del perro caliente');
  });

  test('validate get by City correctly GlobalEvent', () async {
    firestoresMock.collection('global_events').doc('globalEventCommerce1').set(Mocks.mapGlobalEventModelMock);

    firestoresMock.collection('global_events').doc('globalEventCommerce2').set({
      'name': 'Festival de la hamburguesa',
      'description': 'Festival de la hamburguesa en el malecón del rio',
      'longitude': -74.789077,
      'latitude': 10.987877, 
      'radious': 100,
      'scheduleDate': '05/05/2026 12:00',
      'startDate': '05/05/2026 12:00',
      'endDate': '05/05/2026 18:00',
      'department': 'ATLANTICO',
      'city': 'PUERTO COLOMBIA',
      'status': 'PUBLICADO'
    });
    List<GlobalEventModel> list = await datasource.getActiveByCity('BARRANQUILLA','ATLANTICO');
    expect(list.length, 1);
    expect(list[0].name, 'Festival del perro caliente');
  });

  test('validate get published correctly GlobalEvent', () async {
    firestoresMock.collection('global_events').doc('globalEventCommerce1').set(Mocks.mapGlobalEventModelMock);

    firestoresMock.collection('global_events').doc('globalEventCommerce2').set({
      'name': 'Festival de la hamburguesa',
      'description': 'Festival de la hamburguesa en el malecón del rio',
      'longitude': -74.789077,
      'latitude': 10.987877, 
      'radious': 100,
      'scheduleDate': '05/05/2026 12:00',
      'startDate': '05/05/2026 12:00',
      'endDate': '05/05/2026 18:00',
      'department': 'ATLANTICO',
      'city': 'PUERTO COLOMBIA',
      'status': 'CANCELADO'
    });
    List<GlobalEventModel> list = await datasource.getAllActive();
    expect(list.length, 1);
    expect(list[0].name, 'Festival del perro caliente');
  });

  test('validate update correctly GlobalEvent', () async {
    firestoresMock.collection('global_events').doc('globalEventCommerce1').set(Mocks.mapGlobalEventModelMock);

    final resultPrevious = await firestoresMock
        .collection('global_events')
        .doc('globalEventCommerce1')
        .get();

    expect(resultPrevious['description'], 'Festival del perro caliente en la plaza de la paz');
    expect(resultPrevious['name'], 'Festival del perro caliente');

    await datasource.update(
        'globalEventCommerce1',
        GlobalEventModel(
      id: '1',
      name: 'Festival del perro caliente',
      description: 'Festival del perro caliente en el malecón del rio',
      longitude: -74.789077,
      latitude: 10.987877, 
      radious: 100,
      scheduleDate: '05/05/2026 12:00',
      startDate: '05/05/2026 12:00',
      endDate: '05/05/2026 18:00',
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      status: 'PUBLICADO'));
    final result = await firestoresMock
        .collection('global_events')
        .doc('globalEventCommerce1')
        .get();
    expect(result['description'], 'Festival del perro caliente en el malecón del rio');
    expect(result['name'], 'Festival del perro caliente');
  });

  test('validate get byId correctly GlobalEvent', () async {
    firestoresMock.collection('global_events').doc('globalEventCommerce1').set(Mocks.mapGlobalEventModelMock);
    GlobalEventModel? value = await datasource.getById('globalEventCommerce1');
    expect(value, isNotNull);
    expect(value!.description, 'Festival del perro caliente en la plaza de la paz');
  });

  test('validate delete byId correctly GlobalEvent', () async {
    firestoresMock.collection('global_events').doc('globalEventCommerce1').set(Mocks.mapGlobalEventModelMock);
    await datasource.delete('globalEventCommerce1');
    final result = await firestoresMock
        .collection('global_events')
        .doc('globalEventCommerce1')
        .get();
    expect(result.data(), isNull);
  });

  tearDownAll(() {
    container?.dispose();
  });
}
