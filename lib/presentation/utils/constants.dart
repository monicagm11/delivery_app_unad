import 'package:delivery_app/domain/entities/table_column_config.dart';

class Constants {
  static const headersCommerce = [
    TableColumnConfig(label: "Nombre", code: "name"),
    TableColumnConfig(label: 'Identificación', code: 'fullDocument'),
    TableColumnConfig(label: 'Contacto', code: 'contactName'),
    TableColumnConfig(label: 'Teléfono', code: 'phone'),
    TableColumnConfig(label: 'Email', code: 'email'),
    TableColumnConfig(label: "Estado", code: "status"),
  ];
}