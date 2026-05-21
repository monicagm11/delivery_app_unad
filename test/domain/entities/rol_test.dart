import 'package:delivery_app/domain/entities/rol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of Rol created correctly', () {
    Rol model = Mocks.rolMock;
    expect(model.name, 'UNKNOWN');
    expect(model.id, 'UNKNOWN');
    expect(model.functionConfig.length, 1);
    expect(model.code, 'UNKNOWN');
    expect(model.rolEnableToCreate.length, 1);
  });

  test('Verify properties of Rol created from map', () {
    Map<String, dynamic> map = Mocks.mapRolMock;
    Rol model = Rol.fromMap(map);
    expect(model.name, 'UNKNOWN');
    expect(model.id, 'UNKNOWN');
    expect(model.functionConfig.length, 1);
    expect(model.code, 'UNKNOWN');
    expect(model.rolEnableToCreate.length, 1);
  });

  test('Verify properties of FunctionConfig created correctly', () {
    FunctionConfig model = Mocks.functionConfigMock;
    expect(model.functionName, 'UNKNOWN');
    expect(model.readData, false);
    expect(model.createData, false);
    expect(model.updateData, false);
    expect(model.enabled, false);
  });

  test('Verify properties of FunctionConfig created from map', () {
    Map<String, dynamic> map = Mocks.mapFunctionConfigMock;
    FunctionConfig model = FunctionConfig.fromMap(map);

    expect(model.functionName, 'UNKNOWN');
    expect(model.readData, false);
    expect(model.createData, false);
    expect(model.updateData, false);
    expect(model.enabled, false);
  });
}