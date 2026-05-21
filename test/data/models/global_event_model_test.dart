import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of GlobalEvent created correctly', () {
    GlobalEventModel model = Mocks.globalEventModelMock;
    expect(model.id, '1');
    expect(model.name, 'Festival del perro caliente');
    expect(model.description, 'Festival del perro caliente en la plaza de la paz');
    expect(model.longitude, -74.789077);
    expect(model.latitude, 10.987877);
    expect(model.radious, 100);
    expect(model.scheduleDate, '05/05/2026 12:00');
    expect(model.endDate, '05/05/2026 18:00');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
    expect(model.status, 'PUBLICADO');
  });

  test('Verify properties of GlobalEvent created from map', () {
    Map<String, dynamic> map = Mocks.mapGlobalEventModelMock;

    GlobalEventModel model = GlobalEventModel.fromMap(map);
    expect(model.id, '1');
    expect(model.name, 'Festival del perro caliente');
    expect(model.description, 'Festival del perro caliente en la plaza de la paz');
    expect(model.longitude, -74.789077);
    expect(model.latitude, 10.987877);
    expect(model.radious, 100);
    expect(model.scheduleDate, '05/05/2026 12:00');
    expect(model.endDate, '05/05/2026 18:00');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
    expect(model.status, 'PUBLICADO');
  });

  test('Verify properties of Map created from GlobalEventModel', () {
    GlobalEventModel model = Mocks.globalEventModelMock;
    Map<String, dynamic> map = model.toMap();

    expect(map['id'], '1');
    expect(map['name'], 'Festival del perro caliente');
    expect(map['description'], 'Festival del perro caliente en la plaza de la paz');
    expect(map['longitude'], -74.789077);
    expect(map['latitude'], 10.987877);
    expect(map['radious'], 100);
    expect(map['scheduleDate'], '05/05/2026 12:00');
    expect(map['endDate'], '05/05/2026 18:00');
    expect(map['department'], 'ATLANTICO');
    expect(map['city'], 'BARRANQUILLA');
    expect(map['status'], 'PUBLICADO');
  });
}