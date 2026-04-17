import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/menu_item.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/screens/category_crud_screen.dart';
import 'package:delivery_app/presentation/screens/commerce_crud_screen.dart';
import 'package:delivery_app/presentation/screens/global_event_crud_screen.dart';
import 'package:delivery_app/presentation/screens/local_event_crud_screen.dart';
import 'package:delivery_app/presentation/screens/product_crud_screen.dart';
import 'package:delivery_app/presentation/screens/user_crud_screen.dart';
import 'package:flutter/material.dart';

class Constants {
  static const String productsFolder = 'products';
  static const String bucketName =
      'delivery-flutter-app-unad.firebasestorage.app';

  static const String adminRolCode = 'ADMINISTRADOR';

  static const String productFunction = 'products';
  static const String userFunction = 'users';
  static const String categoryFunction = 'categories';
  static const String eventFunction = 'events';
  static const String globalEventFunction = 'globalEvents';
  static const String commerceFunction = 'commerces';

  static const String programmedStatus = 'PROGRAMADO';
  static const String publishedStatus = 'PUBLICADO';
  static const String startedStatus = 'INICIADO';
  static const String endedStatus = 'FINALIZADO';
  static const String canceledStatus = 'CANCELADO';

  static Rol defaultRol = Rol(
      name: 'UNKNOWN',
      id: 'UNKNOWN',
      functionConfig: {},
      code: 'UNKNOWN',
      enabled: true,
      rolEnableToCreate: []);

  static FunctionConfig defaultFunctionConfig = FunctionConfig(
      functionName: 'UNKNOWN',
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
    TableColumnConfig(label: 'Fecha Programada', code: 'scheduleDate'),
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

  static const menuItems = [
    MenuItem(
      title: 'Comercios',
      icon: Icons.store_outlined,
      code: Constants.commerceFunction,
      screen: CommerceCrudScreen(),
    ),
    MenuItem(
      title: 'Eventos Globales',
      icon: Icons.event_available,
      code: Constants.globalEventFunction,
      screen: GlobalEventCrudScreen(),
    ),
    MenuItem(
      title: 'Eventos',
      icon: Icons.fastfood,
      code: Constants.eventFunction,
      screen: LocalEventCrudScreen(),
    ),
    MenuItem(
      title: 'Categorías',
      icon: Icons.category_outlined,
      code: Constants.categoryFunction,
      screen: CategoryCrudScreen(),
    ),
    MenuItem(
      title: 'Productos',
      code: Constants.productFunction,
      icon: Icons.inventory_2_outlined,
      screen: ProductCrudScreen(),
    ),
    MenuItem(
      title: 'Usuarios',
      code: Constants.userFunction,
      icon: Icons.people_outline,
      screen: UserCrudScreen(),
    ),
  ];
}
