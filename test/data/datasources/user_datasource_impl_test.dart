import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/user_datasource.dart';
import 'package:delivery_app/data/datasources/user_datasource_impl.dart';
import 'package:delivery_app/data/models/user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  late UserDatasource datasource;
  late FakeFirebaseFirestore firestoresMock;
  ProviderContainer? container;

  setUp(() {
    firestoresMock = FakeFirebaseFirestore();
    datasource = UserDatasourceImpl(firestore: firestoresMock);
  });

  test('Verify provider of datasource', () async {
    container = ProviderContainer(
      overrides: [
        firebaseFirestoreProvider.overrideWithValue(
          firestoresMock,
        ),
      ],
    );
    final datasourceInyected = container!.read(userDatasourceProvider);
    expect(datasourceInyected, isA<UserDatasourceImpl>());
    expect(
        (datasourceInyected as UserDatasourceImpl).firestore, firestoresMock);
  });

  test('validate get empty list correctly User', () async {
    List<UserModel> list = await datasource.getAll();
    expect(list, isEmpty);
  });

  test('validate create a new register correctly User', () async {
    await datasource.create(Mocks.userModelMock);
    final result = await firestoresMock.collection('users').get();
    expect(result.docs.length, 1);
    expect(result.docs[0]['name'], 'Maria');
  });

  test('validate getByRolAndEventId filter registers correctly', () async {
    firestoresMock.collection('users').doc('user1').set({
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
    });

    firestoresMock.collection('users').doc('user2').set({
      'name': 'Pedro',
      'lastname': 'Perez',
      'fullname': 'Pedro Perez',
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
      'rol': 'LOGISTICO'
    });

    firestoresMock.collection('users').doc('user3').set({
      'name': 'Pablo',
      'lastname': 'Lopez',
      'fullname': 'Pablo Lopez',
      'document': '123456789',
      'identificationType': 'CC',
      'fullDocument': 'CC 123456789',
      'phone': '3000010203',
      'email': 'mariasuarez@ejemplo.com',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'address': 'CL 11 11 11',
      'commerce': 'YTRE999',
      'occupation': 'Administrador general',
      'currentEventId': '2',
      'token': 'nfiergbseifgre3y443rsb73ehsb',
      'userId': 'POIU908',
      'status': 'ACTIVO',
      'rol': 'LOGISTICO'
    });

    List<UserModel> list = await datasource.getByRolAndEventId('LOGISTICO', '1');
    expect(list.length, 1);
    expect(list[0].fullname, 'Pedro Perez');
  });

  test('validate update correctly User', () async {
    firestoresMock.collection('users').doc('user1').set({
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
    });

    final resultPrevious =
        await firestoresMock.collection('users').doc('user1').get();

    expect(resultPrevious['status'], 'ACTIVO');
    expect(resultPrevious['rol'], 'ADMINISTRADOR');

    await datasource.update(
        'user1',
        UserModel(
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
            status: 'INACTIVO',
            rol: 'ADMINISTRADOR_EVENTOS'));
    final result = await firestoresMock.collection('users').doc('user1').get();
    expect(result['status'], 'INACTIVO');
    expect(result['rol'], 'ADMINISTRADOR_EVENTOS');
  });

 test('validate updateCurrentEventId correctly User', () async {
    firestoresMock.collection('users').doc('user1').set({
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
    });

    final resultPrevious =
        await firestoresMock.collection('users').doc('user1').get();

    expect(resultPrevious['currentEventId'], '1');

    await datasource.updateCurrentEventId('user1', '2');
    final result = await firestoresMock.collection('users').doc('user1').get();
    expect(result['currentEventId'], '2');
  });

  test('validate get byId correctly User', () async {
    firestoresMock.collection('users').doc('user1').set({
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
    });
    UserModel? value = await datasource.getById('user1');
    expect(value, isNotNull);
    expect(value!.city, 'BARRANQUILLA');
  });

  test('validate delete byId correctly User', () async {
    firestoresMock.collection('users').doc('user1').set({
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
    });
    await datasource.delete('user1');
    final result = await firestoresMock.collection('users').doc('user1').get();
    expect(result.data(), isNull);
  });

  tearDownAll(() {
    container?.dispose();
  });
}
