import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of LocalEvent created correctly', () {
    LocalEventModel model = Mocks.localEventModelMock;
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
    expect(model.productsIdList.length, 2);
    expect(model.commerce, 'ABCDE123');
    expect(model.locationClientType, 'numberedChair');
    expect(model.idGlobalEvent, '11');
  });

  test('Verify properties of LocalEvent created from map', () {
    Map<String, dynamic> map = Mocks.mapLocalEventModelMock;

    LocalEventModel model = LocalEventModel.fromMap(map);
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
    expect(model.productsIdList.length, 2);
    expect(model.commerce, 'ABCDE123');
    expect(model.locationClientType, 'numberedChair');
    expect(model.idGlobalEvent, '11');
  });

  test('Verify properties of Map created from LocalEventModel', () {
    LocalEventModel model = Mocks.localEventModelMock;
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
    expect(map['products'].length, 2);
    expect(map['commerce'], 'ABCDE123');
    expect(map['locationClientType'], 'numberedChair');
    expect(map['idGlobalEvent'], '11');
  });
}