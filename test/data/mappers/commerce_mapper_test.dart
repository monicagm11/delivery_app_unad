import 'package:delivery_app/data/mappers/commerce_mapper.dart';
import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final CommerceMapper mapper;

  setUpAll(() {
    mapper = CommerceMapper();
  });
  test('verify properties of convert commerce to commerceModel', () {
    Commerce entity = Mocks.commerceMock;
    CommerceModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.id, 'ADGF234');
    expect(model?.name, 'Pizzeria MyG');
    expect(model?.document, '123456');
    expect(model?.identificationType, 'NIT');
    expect(model?.phone, '3001234567');
    expect(model?.address, 'CL 1 2-3');
    expect(model?.email, 'ejemplo@gmail.com');
    expect(model?.department, 'ATLANTICO');
    expect(model?.city, 'BARRANQUILLA');
    expect(model?.status, 'ACTIVO');
    expect(model?.contactName, 'Samanta Collazos');
    expect(model?.urlImage, 'http://www.ejemplo.com/ejemplo.jpg');
    expect(model?.urlImageQR, 'http://www.ejemplo.com/logo.jpg');
    expect(model?.fullDocument, 'NIT 123456');
  });

  test('Verify return null when entity is null', () {
    Commerce? entity;
    CommerceModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert commerceModel to commerce', () {
    CommerceModel model = Mocks.commerceModelMock;
    Commerce? entity = mapper.toEntity(model);
    expect(entity, isNotNull);
    expect(entity?.id, 'ADGF234');
    expect(entity?.name, 'Pizzeria MyG');
    expect(entity?.document, '123456');
    expect(entity?.identificationType, 'NIT');
    expect(entity?.phone, '3001234567');
    expect(entity?.address, 'CL 1 2-3');
    expect(entity?.email, 'ejemplo@gmail.com');
    expect(entity?.department, 'ATLANTICO');
    expect(entity?.city, 'BARRANQUILLA');
    expect(entity?.status, 'ACTIVO');
    expect(entity?.contactName, 'Samanta Collazos');
    expect(entity?.urlImage, 'http://www.ejemplo.com/ejemplo.jpg');
    expect(entity?.urlImageQR, 'http://www.ejemplo.com/logo.jpg');
    expect(entity?.fullDocument, 'NIT 123456');
  });

  test('Verify return null when model is null', () {
    CommerceModel? model;
    Commerce? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}