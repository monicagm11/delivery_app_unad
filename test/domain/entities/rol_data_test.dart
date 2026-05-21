import 'package:delivery_app/domain/entities/rol_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of RolData created correctly', () {
    RolData model = RolData(rol: 'ADMINISTRADOR', commerce: '123456');
    expect(model.rol, 'ADMINISTRADOR');
    expect(model.commerce, '123456');
  });
}