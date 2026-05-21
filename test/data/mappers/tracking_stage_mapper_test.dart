import 'package:delivery_app/data/mappers/tracking_stage_mapper.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {

  late final TrackingStageMapper mapper;

  setUpAll(() {
    mapper = TrackingStageMapper();
  });
  test('verify properties of convert TrackingStage to TrackingStageModel', () {
    TrackingStage entity = Mocks.trackingStageMock;
    TrackingStageModel? model = mapper.toModel(entity);
    expect(model, isNotNull);
    expect(model?.date?.day, 30);
    expect(model?.name, 'Pedido creado');
    expect(model?.completed, true);
  });

  test('Verify return null when entity is null', () {
    TrackingStage? entity;
    TrackingStageModel? model = mapper.toModel(entity);
    expect(model, isNull);
  });

  test('verify properties of convert TrackingStageModel to TrackingStage', () {
    TrackingStageModel model = Mocks.trackingStageModelMock;
    TrackingStage? entity = mapper.toEntity(model);
    expect(entity, isNotNull);
    expect(entity?.date?.day, 30);
    expect(entity?.name, 'Pedido creado');
    expect(entity?.completed, true);
  });

  test('Verify return null when model is null', () {
    TrackingStageModel? model;
    TrackingStage? entity = mapper.toEntity(model);
    expect(entity, isNull);
  });
}