import 'package:delivery_app/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of User created correctly', () {
    UserModel model = Mocks.userModelMock;
    expect(model.id, 'POIU908');
    expect(model.name, 'Maria');
    expect(model.lastname, 'Suarez');
    expect(model.document, '123456789');
    expect(model.identificationType, 'CC');
    expect(model.fullDocument, 'CC 123456789');
    expect(model.phone, '3000010203');
    expect(model.email, 'mariasuarez@ejemplo.com');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
    expect(model.address, 'CL 11 11 11');
    expect(model.commerce, 'ABCDE123');
    expect(model.occupation, 'Administrador general');
    expect(model.currentEventId, '1');
    expect(model.token, 'nfiergbseifgre3y443rsb73ehsb');
    expect(model.userId, 'POIU908');
    expect(model.status, 'ACTIVO');
    expect(model.rol, 'ADMINISTRADOR');
  });

  test('Verify properties of User created from map', () {
    Map<String, dynamic> map = Mocks.mapUserMock;

    UserModel model = UserModel.fromMap(map);
    expect(model.id, 'POIU908');
    expect(model.name, 'Maria');
    expect(model.lastname, 'Suarez');
    expect(model.document, '123456789');
    expect(model.identificationType, 'CC');
    expect(model.fullDocument, 'CC 123456789');
    expect(model.phone, '3000010203');
    expect(model.email, 'mariasuarez@ejemplo.com');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
    expect(model.address, 'CL 11 11 11');
    expect(model.commerce, 'ABCDE123');
    expect(model.occupation, 'Administrador general');
    expect(model.currentEventId, '1');
    expect(model.token, 'nfiergbseifgre3y443rsb73ehsb');
    expect(model.userId, 'POIU908');
    expect(model.status, 'ACTIVO');
    expect(model.rol, 'ADMINISTRADOR');
  });

  test('Verify properties of Map created from UserModel', () {
    UserModel model = Mocks.userModelMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['id'], 'POIU908');
    expect(map['name'], 'Maria');
    expect(map['lastname'], 'Suarez');
    expect(map['document'], '123456789');
    expect(map['identificationType'], 'CC');
    expect(map['fullDocument'], 'CC 123456789');
    expect(map['phone'], '3000010203');
    expect(map['email'], 'mariasuarez@ejemplo.com');
    expect(map['department'], 'ATLANTICO');
    expect(map['city'], 'BARRANQUILLA');
    expect(map['address'], 'CL 11 11 11');
    expect(map['commerce'], 'ABCDE123');
    expect(map['occupation'], 'Administrador general');
    expect(map['currentEventId'], '1');
    expect(map['token'], 'nfiergbseifgre3y443rsb73ehsb');
    expect(map['userId'], 'POIU908');
    expect(map['status'], 'ACTIVO');
    expect(map['rol'], 'ADMINISTRADOR');
  });
}