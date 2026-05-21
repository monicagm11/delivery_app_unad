import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of IdentificationData created correctly', () {
    IdentificationData model = IdentificationData(code: 'CC', number: '123456');
    expect(model.code, 'CC');
    expect(model.number, '123456');
    expect(model.full, 'CC 123456');
  });
}