
import 'package:delivery_app/data/mappers/request_event_mapper.dart';
import 'package:delivery_app/data/models/request_event_model.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final RequestEventMapper mapper;

  setUpAll(() {
    mapper = RequestEventMapper();
  });
  test('verify properties of convert requestEvent to requestEventModel', () {
    RequestEvent entity = Mocks.requestEventMock;
    RequestEventModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.id, 'ABC123DEF');
    expect(model?.eventId, '1');
    expect(model?.creationDate, '05/05/2026 12:00');
    expect(model?.status, 'ACTIVO');
    expect(model?.commerceId, 'ABCDE123');
    expect(model?.productsIdList.length, 2);
    expect(model?.locationClientType, 'numberedChair');
  });

  test('Verify return null when entity is null', () {
    RequestEvent? entity;
    RequestEventModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert requestEventModel to requestEvent', () {
    RequestEventModel model = Mocks.requestEventModelMock;
    RequestEvent? entity = mapper.toEntity(model);
    expect(entity, isNotNull);
    expect(entity?.id, 'ABC123DEF');
    expect(entity?.eventId, '1');
    expect(entity?.creationDate, '05/05/2026 12:00');
    expect(entity?.status, 'ACTIVO');
    expect(entity?.commerceId, 'ABCDE123');
    expect(entity?.productsIdList.length, 2);
    expect(entity?.locationClientType, 'numberedChair');
  });

  test('Verify return null when model is null', () {
    RequestEventModel? model;
    RequestEvent? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}