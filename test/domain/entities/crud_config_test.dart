import 'package:delivery_app/domain/entities/crud_config.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of CrudConfig created correctly', () {
    CrudConfig model = Mocks.crudConfigMock;
    expect(model.columns.length, 4);
    expect(model.formConfig.length, 2);
    expect(model.name, 'name');
  });
}