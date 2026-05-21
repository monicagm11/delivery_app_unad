import 'package:delivery_app/data/mappers/user_mapper.dart';
import 'package:delivery_app/data/models/user_model.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final UserMapper mapper;

  setUpAll(() {
    mapper = UserMapper();
  });
  test('verify properties of convert user to userModel', () {
    User entity = Mocks.userMock;
    UserModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.id, 'POIU908');
    expect(model?.name, 'Maria');
    expect(model?.lastname, 'Suarez');
    expect(model?.document, '123456789');
    expect(model?.identificationType, 'CC');
    expect(model?.fullDocument, 'CC 123456789');
    expect(model?.phone, '3000010203');
    expect(model?.email, 'mariasuarez@ejemplo.com');
    expect(model?.department, 'ATLANTICO');
    expect(model?.city, 'BARRANQUILLA');
    expect(model?.address, 'CL 11 11 11');
    expect(model?.commerce, 'ABCDE123');
    expect(model?.occupation, 'Administrador general');
    expect(model?.currentEventId, '1');
    expect(model?.token, 'nfiergbseifgre3y443rsb73ehsb');
    expect(model?.userId, 'POIU908');
    expect(model?.status, 'ACTIVO');
    expect(model?.rol, 'ADMINISTRADOR');
  });

  test('Verify return null when entity is null', () {
    User? entity;
    UserModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert userModel to user', () {
    UserModel model = Mocks.userModelMock;
    User? entity = mapper.toEntity(model);
    expect(entity, isNotNull);
    expect(entity?.id, 'POIU908');
    expect(entity?.name, 'Maria');
    expect(entity?.lastname, 'Suarez');
    expect(entity?.document, '123456789');
    expect(entity?.identificationType, 'CC');
    expect(entity?.fullDocument, 'CC 123456789');
    expect(entity?.phone, '3000010203');
    expect(entity?.email, 'mariasuarez@ejemplo.com');
    expect(entity?.department, 'ATLANTICO');
    expect(entity?.city, 'BARRANQUILLA');
    expect(entity?.address, 'CL 11 11 11');
    expect(entity?.commerce, 'ABCDE123');
    expect(entity?.occupation, 'Administrador general');
    expect(entity?.currentEventId, '1');
    expect(entity?.token, 'nfiergbseifgre3y443rsb73ehsb');
    expect(entity?.userId, 'POIU908');
    expect(entity?.status, 'ACTIVO');
    expect(entity?.rol, 'ADMINISTRADOR');
  });

  test('Verify return null when model is null', () {
    UserModel? model;
    User? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}