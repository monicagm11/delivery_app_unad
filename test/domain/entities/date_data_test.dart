import 'package:delivery_app/domain/entities/date_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of DateData created correctly', () {
    DateData model = DateData(date: '22/05/2026', hour: '04:00', fullDate: '22/05/2026 04:00');
    expect(model.date, '22/05/2026');
    expect(model.hour, '04:00');
    expect(model.fullDate, '22/05/2026 04:00');
  });
}