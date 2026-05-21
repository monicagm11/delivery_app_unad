
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of TableColumnConfig created correctly', () {
    TableColumnConfig model =  TableColumnConfig(label: "Nombre", code: "name");
    expect(model.label, 'Nombre');
    expect(model.code, 'name');
  });
}