import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';

class Constants {
  static const statusOptions = [
    DropdownOption(label: 'Activo', value: 'ACTIVO'),
    DropdownOption(label: 'Inactivo', value: 'INACTIVO')
  ];
  static const headersCommerce = [
    TableColumnConfig(label: "Nombre", code: "name"),
    TableColumnConfig(label: 'Identificación', code: 'fullDocument'),
    TableColumnConfig(label: 'Contacto', code: 'contactName'),
    TableColumnConfig(label: 'Teléfono', code: 'phone'),
    TableColumnConfig(label: 'Email', code: 'email'),
    TableColumnConfig(label: "Estado", code: "status"),
  ];

  static const headersCategory = [
    TableColumnConfig(label: "Nombre", code: "name"),
    TableColumnConfig(label: 'Descripción', code: 'description'),
    TableColumnConfig(label: "Estado", code: "status"),
  ];

  static const headersProducts = [
    TableColumnConfig(label: "Nombre", code: "name"),
    TableColumnConfig(label: 'Descripción', code: 'description'),
    TableColumnConfig(label: 'Precio base', code: 'priceBase'),
    TableColumnConfig(label: '% IVA', code: 'percentageIva'),
    TableColumnConfig(label: 'Precio total', code: 'totalPrice'),
    TableColumnConfig(label: "Estado", code: "status"),
  ];
}
