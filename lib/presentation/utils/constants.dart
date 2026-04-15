import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';

class Constants {
  static const String productsFolder = 'products';
  static const String bucketName = 'delivery-flutter-app-unad.firebasestorage.app';

  static const String adminRolCode = 'ADMINISTRADOR';

  static const String productFunction = 'products';
  static const String userFunction = 'users';
  static const String categoryFunction = 'categories';
  static const String eventFunction = 'events';
  static const String globalEventFunction = 'globalEvents';
  static const String commerceFunction = 'commerces';

  static Rol defaultRol = Rol(
      name: 'UNKNOWN',
      id: 'UNKNOWN',
      functionConfig: {},
      code: 'UNKNOWN',
      enabled: true,
      rolEnableToCreate: []);

  static FunctionConfig defaultFunctionConfig = FunctionConfig(
      readData: false,
      createData: false,
      updateData: false,
      enabled: false);

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

  static const headersEvents = [
    TableColumnConfig(label: "Nombre", code: "name"),
    TableColumnConfig(label: 'Descripción', code: 'description'),
    TableColumnConfig(label: 'Fecha Programada', code: 'scheduleData'),
    TableColumnConfig(label: 'Fecha Inicio', code: 'startDate'),
    TableColumnConfig(label: 'Fecha Fin', code: 'endDate'),
    TableColumnConfig(label: "Estado", code: "status"),
  ];

  static const headersUsers = [
    TableColumnConfig(label: "Nombre", code: "fullname"),
    TableColumnConfig(label: 'Rol', code: 'rol'),
    TableColumnConfig(label: 'Teléfono', code: 'phone'),
    TableColumnConfig(label: 'Email', code: 'email'),
    TableColumnConfig(label: 'Dirección', code: 'address'),
    TableColumnConfig(label: "Estado", code: "status"),
  ];
}
