import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/form_field_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of FormFieldConfig created correctly', () {
    FormFieldConfig model = FormFieldConfig(
        label: 'ID',
        id: 'id',
        enabled: false,
        type: FormFieldType.textInput,
        isRequired: false,
        updateEnable: (_) => false);
    expect(model.label, 'ID');
    expect(model.id, 'id');
    expect(model.enabled, false);
    expect(model.isRequired, false);
    expect(model.type, FormFieldType.textInput);
  });
}