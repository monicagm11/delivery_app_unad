import 'package:delivery_app/domain/entities/event_item.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify correct map from GlobalEvent', () {
    GlobalEvent event = Mocks.globalEventMock;
    EventItem model = EventItem.fromGlobal(event);
    expect(model.id, '1');
    expect(model.name, 'Festival del perro caliente');
    expect(model.description, 'Festival del perro caliente en la plaza de la paz');
    expect(model.scheduleDate, '05/05/2026 12:00');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
    expect(model.status, 'PUBLICADO');
  });

  test('Verify correct map from localEvent', () {
    LocalEvent event = Mocks.localEventMock;
    EventItem model = EventItem.fromLocal(event);
    expect(model.id, '1');
    expect(model.name, 'Festival del perro caliente');
    expect(model.description, 'Festival del perro caliente en la plaza de la paz');
    expect(model.scheduleDate, '05/05/2026 12:00');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
    expect(model.status, 'PUBLICADO');
  });
}