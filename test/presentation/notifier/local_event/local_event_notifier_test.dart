import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/date_data.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/event/create_event_usecase.dart';
import 'package:delivery_app/domain/usecases/event/get_all_events_usecase.dart';
import 'package:delivery_app/domain/usecases/event/get_event_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/event/update_event_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/upload_image_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/presentation/notifier/local_event/local_event_notifier.dart';
import 'package:delivery_app/presentation/notifier/local_event/local_event_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/widgets/map_location_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../usecases_mocks.dart';

void main() {
  late final LocalEventNotifier notifier;
  late final ProviderContainer container;
  late final CreateLocalEventUseCaseMock createLocalEventUseCaseMock;
  late final UpdateLocalEventUseCaseMock updateLocalEventUseCaseMock;
  late final SessionNotiferMock sessionNotiferMock;
  late final UploadImageUseCaseMock uploadImageUseCaseMock;
  late final GetLocalEventByIdUseCaseMock getLocalEventByIdUseCaseMock;
  late final GetLocalEventsByCommerceUseCaseMock getAllLocalEventsUseCaseMock;
  late final GetDepartmentsUseCaseMock getDepartmentsUseCaseMock;
  late final GetProductsByCommerceUsecaseMock getProductsByCommerceUsecaseMock;

  setUpAll(() {
    createLocalEventUseCaseMock = CreateLocalEventUseCaseMock();
    updateLocalEventUseCaseMock = UpdateLocalEventUseCaseMock();
    uploadImageUseCaseMock = UploadImageUseCaseMock();
    sessionNotiferMock = SessionNotiferMock();
    getLocalEventByIdUseCaseMock = GetLocalEventByIdUseCaseMock();
    getAllLocalEventsUseCaseMock = GetLocalEventsByCommerceUseCaseMock();
    getDepartmentsUseCaseMock = GetDepartmentsUseCaseMock();
    getProductsByCommerceUsecaseMock = GetProductsByCommerceUsecaseMock();

    notifier = LocalEventNotifier(
        createUseCase: createLocalEventUseCaseMock,
        updateUseCase: updateLocalEventUseCaseMock,
        getByIdUseCase: getLocalEventByIdUseCaseMock,
        getAllUseCase: getAllLocalEventsUseCaseMock,
        uploadImageUseCase: uploadImageUseCaseMock,
        getDepartmentsUseCase: getDepartmentsUseCaseMock,
        getProductsByCommerceUsecase: getProductsByCommerceUsecaseMock,
        commerceId: '123456',
        rolConfig: Rol(
            name: 'ADMINISTRADOR',
            id: 'ADMINISTRADOR',
            functionConfig: {
              'localEvents': FunctionConfig(
                  functionName: 'localEvents',
                  readData: true,
                  createData: true,
                  updateData: true,
                  enabled: true)
            },
            code: 'ADMINISTRADOR',
            enabled: true,
            rolEnableToCreate: ['ADMINISTRADOR']));

    container = ProviderContainer(overrides: [
      createLocalEventUseCaseProvider
          .overrideWithValue(createLocalEventUseCaseMock),
      updateLocalEventUseCaseProvider
          .overrideWithValue(updateLocalEventUseCaseMock),
      getLocalEventByIdUseCaseProvider
          .overrideWithValue(getLocalEventByIdUseCaseMock),
      getDepartmentsUseCaseProvider
          .overrideWithValue(getDepartmentsUseCaseMock),
      getAllProductsUseCaseProvider
          .overrideWithValue(getProductsByCommerceUsecaseMock),
      getLocalEventsByCommerceUseCaseProvider
          .overrideWithValue(getAllLocalEventsUseCaseMock),
      sessionNotifierProvider.overrideWith((ref) => sessionNotiferMock),
      uploadImageUseCaseProvider.overrideWithValue(uploadImageUseCaseMock)
    ]);
    registerFallbackValue(Mocks.localEventMock);
    when(() => createLocalEventUseCaseMock.call(any()))
        .thenAnswer((_) async => {});
    when(() => updateLocalEventUseCaseMock.call(any(), any()))
        .thenAnswer((_) async => {});
    when(() => getLocalEventByIdUseCaseMock.call(any()))
        .thenAnswer((_) async => Mocks.localEventMock);
    when(() => getDepartmentsUseCaseMock.call()).thenAnswer((_) async => [
          Department(
              name: 'ATLANTICO',
              cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])
        ]);
    when(() => getProductsByCommerceUsecaseMock.call(any()))
        .thenAnswer((_) async => [Mocks.productMock]);
    when(() => uploadImageUseCaseMock.call(
        path: any(named: 'path'),
        bytes: any(named: 'bytes'),
        folder: any(named: 'folder'))).thenAnswer((_) async => '123456');
  });

  group('LocalEventNotifier test', () {
    test('Verify provider of notifier', () async {
      final notifierState = container.read(localEventNotifierProvider);
      expect(notifierState, isA<LocalEventState>());
    });

    test('initial state', () {
      expect(notifier.state.isLoading, false);
    });

    test('validate init method invoke usecases', () async {
      when(() => getAllLocalEventsUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.localEventMock]);
      await notifier.init();
      verify(
        () => getAllLocalEventsUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Festival del perro caliente');
    });

    test('validate load all method invoke usecases', () async {
      when(() => getAllLocalEventsUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.localEventMock]);
      await notifier.loadAll();
      expect(notifier.state.data[0]['name'], 'Festival del perro caliente');
    });

    test('validate error message when exception', () async {
      when(() => getAllLocalEventsUseCaseMock.call(any()))
          .thenThrow(Exception('ERROR'));
      await notifier.loadAll();
      expect(notifier.state.data, isEmpty);
      expect(notifier.state.errorMessage, isNotNull);
    });

    test('validate create method invoke usecases', () async {
      when(() => getAllLocalEventsUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.localEventMock]);
      await notifier.create({
        'id': '1',
        'name': 'Festival del perro caliente',
        'description': 'Festival del perro caliente en la plaza de la paz',
        'location': MapLocationData(
          longitude: -74.789077,
          latitude: 10.987877,
          radious: 100,
        ),
        'products': [CheckboxOption(label: 'Hamburguesa', value: '1')],
        'scheduleDate': DateData(
            date: '05/05/2026', hour: '14:00', fullDate: '05/05/2026 14:00'),
        'startDate': '05/05/2026 12:00',
        'endDate': '05/05/2026 18:00',
        'status': 'PUBLICADO',
        'locationClientType': 'numberedChair',
        'cityDepartment':
            CityData(city: 'BARRANQUILLA', department: 'ATLANTICO')
      });
      verify(
        () => createLocalEventUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Festival del perro caliente');
    });

    test('validate update method invoke usecases', () async {
      when(() => getAllLocalEventsUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.localEventMock]);

      await notifier.update('1', {
        'id': '1',
        'name': 'Festival del perro caliente',
        'description': 'Festival del perro caliente en la plaza de la paz',
        'location': MapLocationData(
          longitude: -74.789077,
          latitude: 10.987877,
          radious: 100,
        ),
        'products': [CheckboxOption(label: 'Hamburguesa', value: '1')],
        'scheduleDate': DateData(
            date: '05/05/2026', hour: '14:00', fullDate: '05/05/2026 14:00'),
        'startDate': '05/05/2026 12:00',
        'endDate': '05/05/2026 18:00',
        'status': 'PUBLICADO',
        'locationClientType': 'numberedChair',
        'cityDepartment':
            CityData(city: 'BARRANQUILLA', department: 'ATLANTICO')
      });
      verify(
        () => updateLocalEventUseCaseMock.call(any(), any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Festival del perro caliente');
    });

    test('validate open form', () {
      notifier.openForm();
      expect(notifier.state.showForm, isTrue);
    });

    test('validate close form', () {
      notifier.closeForm();
      expect(notifier.state.showForm, isFalse);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
