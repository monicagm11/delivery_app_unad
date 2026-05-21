import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of CityData created correctly', () {
    CityData model = CityData(department: 'ATLANTICO', city: 'BARRANQUILLA');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
  });
}