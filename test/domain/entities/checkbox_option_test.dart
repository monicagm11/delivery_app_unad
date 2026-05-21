import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of CheckboxOption created correctly', () {
    CheckboxOption model = CheckboxOption(value: 'ADMINISTRADOR', label: 'Administrador');
    expect(model.value, 'ADMINISTRADOR');
    expect(model.label, 'Administrador');
  });
}