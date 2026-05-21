import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of TrackingStage created correctly', () {
    TrackingStage model = Mocks.trackingStageMock;
    expect(model.completed, true);
    expect(model.name, 'Pedido creado');
    expect(model.date?.day, 30);
  });

  test('Verify properties of TrackingStage created from map', () {
    Map<String, dynamic> map = Mocks.mapTrackingStageMock;

    TrackingStage model = TrackingStage.fromMap(map);
    expect(model.completed, true);
    expect(model.name, 'Pedido creado');
  });

  test('Verify properties of Map created from TrackingStage', () {
    TrackingStage model = Mocks.trackingStageMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['completed'], true);
    expect(map['name'], 'Pedido creado');
    expect(map['date'],  DateTime(2026, 4, 30));
  });
}