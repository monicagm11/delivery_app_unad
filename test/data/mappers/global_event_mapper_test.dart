import 'package:delivery_app/data/mappers/global_event_mapper.dart';
import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final GlobalEventMapper mapper;

  setUpAll(() {
    mapper = GlobalEventMapper();
  });
  test('verify properties of convert GlobalEvent to GlobalEventModel', () {
    GlobalEvent entity = Mocks.globalEventMock;
    GlobalEventModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.id, '1');
    expect(model?.name, 'Festival del perro caliente');
    expect(model?.description, 'Festival del perro caliente en la plaza de la paz');
    expect(model?.longitude, -74.789077);
    expect(model?.latitude, 10.987877);
    expect(model?.radious, 100);
    expect(model?.scheduleDate, '05/05/2026 12:00');
    expect(model?.endDate, '05/05/2026 18:00');
    expect(model?.department, 'ATLANTICO');
    expect(model?.city, 'BARRANQUILLA');
    expect(model?.status, 'PUBLICADO');
  });

  test('Verify return null when entity is null', () {
    GlobalEvent? entity;
    GlobalEventModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert GlobalEventModel to GlobalEvent', () {
    GlobalEventModel model = Mocks.globalEventModelMock;
    GlobalEvent? entity = mapper.toEntity(model);
    expect(entity, isNotNull);
    expect(entity?.id, '1');
    expect(entity?.name, 'Festival del perro caliente');
    expect(entity?.description, 'Festival del perro caliente en la plaza de la paz');
    expect(entity?.longitude, -74.789077);
    expect(entity?.latitude, 10.987877);
    expect(entity?.radious, 100);
    expect(entity?.scheduleDate, '05/05/2026 12:00');
    expect(entity?.endDate, '05/05/2026 18:00');
    expect(entity?.department, 'ATLANTICO');
    expect(entity?.city, 'BARRANQUILLA');
    expect(entity?.status, 'PUBLICADO');
  });

  test('Verify return null when model is null', () {
    GlobalEventModel? model;
    GlobalEvent? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}