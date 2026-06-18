import 'package:delivery_app/domain/entities/cart_item.dart';
import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/event_item.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:delivery_app/presentation/notifier/cart/cart_state.dart';
import 'package:delivery_app/presentation/notifier/category/category_state.dart';
import 'package:delivery_app/presentation/notifier/checkout/checkout_state.dart';
import 'package:delivery_app/presentation/notifier/city_selector/city_selector_state.dart';
import 'package:delivery_app/presentation/notifier/commerce/commerce_state.dart';
import 'package:delivery_app/presentation/notifier/create_request/create_request_state.dart';
import 'package:delivery_app/presentation/notifier/event_products/event_products_state.dart';
import 'package:delivery_app/presentation/notifier/events_available/events_available_state.dart';
import 'package:delivery_app/presentation/notifier/global_event/global_event_state.dart';
import 'package:delivery_app/presentation/notifier/local_event/local_event_state.dart';
import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:delivery_app/presentation/notifier/product/product_state.dart';
import 'package:delivery_app/presentation/notifier/reset_password/reset_password_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_state.dart';
import 'package:delivery_app/presentation/notifier/user/user_state.dart';

import 'mocks.dart';

class StateMocks {
  static AuthState authStateMock = AuthState(
      status: AuthStatus.success,
      user: Mocks.userMock,
      rolConfig: Mocks.rolMock,
      commerce: Mocks.commerceMock,
      userName: 'Magnolia Valle',
      rolId: 'ADMINISTRADOR',
      hasCitySelected: true);
  
  static CartState cartStateMock = CartState(
      eventId: 'eventId',
      eventName: 'Festival del perro caliente',
      commerce: 'commerce1',
      location: 'B1',
      items: [CartItem(product: Mocks.productMock, quantity: 2)]);

  static CategoryState categoryStateMock = CategoryState(
      isLoading: false,
      showForm: false,
      columns: [
        TableColumnConfig(label: "Nombre", code: "name"),
        TableColumnConfig(label: 'Descripción', code: 'description'),
      ],
      data: [],
      functionConfig: FunctionConfig(
          functionName: 'Category',
          readData: true,
          createData: true,
          updateData: true,
          enabled: true));

  static CheckoutState checkoutStateMock = CheckoutState(
      isLoading: false,
      eventId: 'eventId',
      eventName: 'Festival del perro caliente',
      commerce: Mocks.commerceMock,
      isCheckoutCompleted: false,
      currentOrderId: '1234',
      items: [CartItem(product: Mocks.productMock, quantity: 2)]);

  static CitySelectorState citySelectorStateMock =
      CitySelectorState(departmentOptions: [
    Department(
        name: 'ATLANTICO', cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])
  ], isLoading: false);

  static CommerceState commerceStateMock = CommerceState(
      isLoading: false,
      showForm: false,
      departmentOptions: [
        Department(
            name: 'ATLANTICO',
            cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])
      ],
      columns: [
        TableColumnConfig(label: "Nombre", code: "name"),
        TableColumnConfig(label: 'Descripción', code: 'description'),
      ],
      data: [],
      functionConfig: FunctionConfig(
          functionName: 'Commerce',
          readData: true,
          createData: true,
          updateData: true,
          enabled: true));

  static CreateRequestState createRequestStateMock = CreateRequestState(
      globalEventOptions: [Mocks.globalEventMock],
      isLoading: false,
      showForm: false,
      columns: [
        TableColumnConfig(label: "Nombre", code: "name"),
        TableColumnConfig(label: 'Descripción', code: 'description'),
      ],
      data: [],
      functionConfig: FunctionConfig(
          functionName: 'CreateRequest',
          readData: true,
          createData: true,
          updateData: true,
          enabled: true),
      productOptions: [CheckboxOption(label: 'label', value: 'value')],
      globalEventAvailableOptions: [Mocks.globalEventMock]);

  static EventProductsState eventProductsStateMock = EventProductsState(
      allProducts: [Mocks.productMock],
      categories: [Mocks.categoryMock],
      filteredProducts: [Mocks.productMock],
      commerceId: 'commerceId',
      isLoading: false,
      selectedCategoryId: '1');

  static EventsAvailableState eventsAvailableStateMock = EventsAvailableState(
      eventItems: [
        EventItem(
            id: '1',
            name: 'Festival',
            description: 'Festival del perro caliente',
            scheduleDate: '05/05/2026 14:00',
            startDate: '05/05/2026 14:00',
            city: 'BARRANQUILLA',
            department: 'ATLANTICO',
            status: 'INICIADO',
            isGlobal: false,
            idGlobalEvent: '12',
            commerceId: 'ABC123')
      ],
      filteredEventItems: [
        EventItem(
            id: '1',
            name: 'Festival',
            description: 'Festival del perro caliente',
            scheduleDate: '05/05/2026 14:00',
            startDate: '05/05/2026 14:00',
            city: 'BARRANQUILLA',
            department: 'ATLANTICO',
            status: 'INICIADO',
            isGlobal: false,
            idGlobalEvent: '12',
            commerceId: 'ABC123')
      ],
      department: 'ATLANTICO',
      city: 'BARRANQUILLA',
      isLoading: false,
      currentStateSelected: 'INICIADO',
      localEvents: [
        LocalEvent(
            id: '1',
            name: 'Festival',
            description: 'Festival del perro caliente',
            longitude: -74.789077,
            latitude: 10.987877,
            radious: 100,
            scheduleDate: '05/05/2026 14:00',
            startDate: '05/05/2026 14:00',
            endDate: '05/05/2026 20:00',
            department: 'ATLANTICO',
            city: 'BARRANQUILLA',
            status: 'INICIADO',
            productsIdList: ['ABC123DEF'],
            commerce: 'ABC123',
            locationClientType: 'numberedChair')
      ]);

  static GlobalEventState globalEventStateMock = GlobalEventState(
      isLoading: false,
      showForm: false,
      departmentOptions: [
        Department(
            name: 'ATLANTICO',
            cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])
      ],
      columns: [
        TableColumnConfig(label: "Nombre", code: "name"),
        TableColumnConfig(label: 'Descripción', code: 'description'),
      ],
      data: [],
      functionConfig: FunctionConfig(
          functionName: 'GlobalEvent',
          readData: true,
          createData: true,
          updateData: true,
          enabled: true));

  static LocalEventState localEventStateMock = LocalEventState(
      isLoading: false,
      showForm: false,
      productOptions: [CheckboxOption(label: 'label', value: 'value')],
      departmentOptions: [
        Department(
            name: 'ATLANTICO',
            cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])
      ],
      columns: [
        TableColumnConfig(label: "Nombre", code: "name"),
        TableColumnConfig(label: 'Descripción', code: 'description'),
      ],
      data: [],
      functionConfig: FunctionConfig(
          functionName: 'LocalEvent',
          readData: true,
          createData: true,
          updateData: true,
          enabled: true));

  static ProductState productStateMock = ProductState(
      isLoading: false,
      showForm: false,
      categories: [Mocks.categoryMock],
      categoryOptions: [DropdownOption(label: 'Hamburguesas', value: '1')],
      columns: [
        TableColumnConfig(label: "Nombre", code: "name"),
        TableColumnConfig(label: 'Descripción', code: 'description'),
      ],
      data: [],
      functionConfig: FunctionConfig(
          functionName: 'Product',
          readData: true,
          createData: true,
          updateData: true,
          enabled: true));

  static UserState userStateMock = UserState(
      isLoading: false,
      showForm: false,
      commerceOptions: [DropdownOption(label: 'Pizzeria 1', value: '1')],
      rolOptions: [
        DropdownOption(label: 'Administrador', value: 'ADMINISTRADOR')
      ],
      departmentOptions: [
        Department(
            name: 'ATLANTICO',
            cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])
      ],
      columns: [
        TableColumnConfig(label: "Nombre", code: "name"),
        TableColumnConfig(label: 'Descripción', code: 'description'),
      ],
      data: [],
      functionConfig: FunctionConfig(
          functionName: 'User',
          readData: true,
          createData: true,
          updateData: true,
          enabled: true));

  static ResetPasswordState resetPasswordStateMock =
      ResetPasswordState(status: AuthStatus.loading);

  static SessionState sessionStateMock = SessionState(
    user: Mocks.userMock,
    rolConfig: Mocks.rolMock,
    commerce: Mocks.commerceMock,
    userName: 'Magnolia Valle',
    rolId: 'ADMINISTRADOR',
  );
}
