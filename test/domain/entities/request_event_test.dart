import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of RequestEvent created correctly', () {
    RequestEvent model = Mocks.requestEventMock;
    expect(model, isNotNull);
    expect(model.id, 'ABC123DEF');
    expect(model.eventId, '1');
    expect(model.creationDate, '05/05/2026 12:00');
    expect(model.status, 'ACTIVO');
    expect(model.commerceId, 'ABCDE123');
    expect(model.productsIdList.length, 2);
    expect(model.locationClientType, 'numberedChair');
  });

  test('Verify properties of RequestEvent created from map', () {
    Map<String, dynamic> map = Mocks.mapRequestEventMock;

    RequestEvent model = RequestEvent.fromMap(map);
    expect(model, isNotNull);
    expect(model.id, 'ABC123DEF');
    expect(model.eventId, '1');
    expect(model.creationDate, '05/05/2026 12:00');
    expect(model.status, 'ACTIVO');
    expect(model.commerceId, 'ABCDE123');
    expect(model.productsIdList.length, 2);
    expect(model.locationClientType, 'numberedChair');
  });

  test('Verify properties of Map created from RequestEvent', () {
    RequestEvent model = Mocks.requestEventMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['id'], 'ABC123DEF');
    expect(map['eventId'], '1');
    expect(map['creationDate'], '05/05/2026 12:00');
    expect(map['status'], 'ACTIVO');
    expect(map['commerceId'], 'ABCDE123');
    expect(map['products'].length, 2);
    expect(map['locationClientType'], 'numberedChair');
  });
}