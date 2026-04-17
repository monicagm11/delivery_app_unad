import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:flutter/material.dart';

class CrudConfig {
  final List<TableColumnConfig> columns;
  final List<String>? filtersEnabled;
  final List<FormFieldConfig> formConfig;
  final List<Widget> Function(Map<String, dynamic>)? additionalOptions;
  const CrudConfig({required this.columns, this.filtersEnabled, required this.formConfig, this.additionalOptions});
}