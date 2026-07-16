import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/request_event_datasource.dart';
import 'package:delivery_app/data/datasources/request_event_datasource_impl.dart';
import 'package:delivery_app/data/models/request_event_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late RequestEventDatasource datasource;
  late FakeFirebaseFirestore firestoresMock;
  ProviderContainer? container;

  setUp(() {
    firestoresMock = FakeFirebaseFirestore();
    datasource = RequestEventDatasourceImpl(firestore: firestoresMock);
    registerFallbackValue(Mocks.requestEventModelMock);
  });

  test('Verify provider of RequestEvent datasource', () async {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(
          firestoresMock,
        ),
      ],
    );
    final datasourceInyected = container!.read(requestEventDatasourceProvider);
    expect(datasourceInyected, isA<RequestEventDatasourceImpl>());
    expect((datasourceInyected as RequestEventDatasourceImpl).firestore,
        firestoresMock);
  });

  test('validate get empty list correctly RequestEvent', () async {
    List<RequestEventModel> list = await datasource.getAll();
    expect(list, isEmpty);
  });

  test('validate create a new register correctly RequestEvent', () async {
    await datasource.create(Mocks.requestEventModelMock);
    final result = await firestoresMock.collection('request_events').get();
    expect(result.docs.length, 1);
    expect(result.docs[0]['commerceId'], 'ABCDE123');
  });

  test('validate get byCommerce correctly RequestEvent', () async {
    firestoresMock
        .collection('request_events')
        .doc('requestEventCommerce1')
        .set({
      'commerceId': 'ABCDE123',
      'status': 'ACTIVO',
      'eventId': '1',
      'creationDate': '05/05/2026 12:00',
      'products': ['DEF145', 'FR7F55'],
      'locationClientType': 'numberedChair'
    });

    firestoresMock
        .collection('request_events')
        .doc('requestEventCommerce2')
        .set({
      'id': 'ABC1234DEFG',
      'commerceId': 'ABCDEF1234',
      'status': 'ACTIVO',
      'eventId': '1',
      'creationDate': '15/05/2026 12:00',
      'products': ['AGH675', 'FNDJ90JU'],
      'locationClientType': 'numberedChair'
    });
    List<RequestEventModel> list = await datasource.getByCommerce('ABCDE123');
    expect(list.length, 1);
    expect(list[0].id, 'requestEventCommerce1');
  });

  test('validate update correctly RequestEvent', () async {
    firestoresMock
        .collection('request_events')
        .doc('requestEventCommerce1')
        .set(Mocks.mapRequestEventMock);

    final resultPrevious = await firestoresMock
        .collection('request_events')
        .doc('requestEventCommerce1')
        .get();

    expect(resultPrevious['status'], 'ACTIVO');
    expect(resultPrevious['products'].length, 2);

    await datasource.update(
        'requestEventCommerce1',
        RequestEventModel(
            id: 'ABCDE123',
            commerceId: 'ABCDE123',
            commerceName: 'Pizzeria MyG',
            status: 'INACTIVO',
            eventId: '1',
            creationDate: '05/05/2026 12:00',
            productsIdList: ['DEF145', 'FR7F55', 'YRT3474'],
            locationClientType: 'numberedChair'));

    final result = await firestoresMock
        .collection('request_events')
        .doc('requestEventCommerce1')
        .get();
    expect(result['status'], 'INACTIVO');
    expect(result['products'].length, 3);
  });

  test('validate get byId correctly RequestEvent', () async {
    firestoresMock
        .collection('request_events')
        .doc('requestEventCommerce1')
        .set(Mocks.mapRequestEventMock);
    RequestEventModel? value =
        await datasource.getById('requestEventCommerce1');
    expect(value, isNotNull);
    expect(value!.commerceId, 'ABCDE123');
  });

  test('validate delete byId correctly RequestEvent', () async {
    firestoresMock
        .collection('request_events')
        .doc('requestEventCommerce1')
        .set(Mocks.mapRequestEventMock);
    await datasource.delete('requestEventCommerce1');
    final result = await firestoresMock
        .collection('request_events')
        .doc('requestEventCommerce1')
        .get();
    expect(result.data(), isNull);
  });

  tearDownAll(() {
    container?.dispose();
  });
}
