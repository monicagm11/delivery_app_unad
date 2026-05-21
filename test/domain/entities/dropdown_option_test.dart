import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of DropdownOption created correctly', () {
    DropdownOption model = DropdownOption(value: 'ADMINISTRADOR', label: 'Administrador');
    expect(model.value, 'ADMINISTRADOR');
    expect(model.label, 'Administrador');
  });
}