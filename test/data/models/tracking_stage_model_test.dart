import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of TrackingStage created correctly', () {
    TrackingStageModel model = Mocks.trackingStageModelMock;
    expect(model.completed, true);
    expect(model.name, 'Pedido creado');
    expect(model.date?.day, 30);
  });

  test('Verify properties of TrackingStage created from map', () {
    Map<String, dynamic> map = Mocks.mapTrackingStageMock;

    TrackingStageModel model = TrackingStageModel.fromMap(map);
    expect(model.completed, true);
    expect(model.name, 'Pedido creado');
  });

  test('Verify properties of Map created from TrackingStageModel', () {
    TrackingStageModel model = Mocks.trackingStageModelMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['completed'], true);
    expect(map['name'], 'Pedido creado');
    expect(map['date'],  DateTime(2026, 4, 30));
  });
}