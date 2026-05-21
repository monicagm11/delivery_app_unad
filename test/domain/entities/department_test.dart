import 'package:delivery_app/domain/entities/department.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of Department created correctly', () {
    Department model = Department(name: 'ATLANTICO', cities: ['BARRANQUILLA', 'BARANOA', 'PIOJO']);
    expect(model.name, 'ATLANTICO');
    expect(model.cities.length, 3);
  });
}