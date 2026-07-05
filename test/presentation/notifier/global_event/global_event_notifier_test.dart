import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/date_data.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/functions/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/upload_image_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/create_global_event_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_all_global_events_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_global_event_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/update_global_event_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/presentation/notifier/global_event/global_event_notifier.dart';
import 'package:delivery_app/presentation/notifier/global_event/global_event_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/widgets/map_location_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../usecases_mocks.dart';

void main() {
  late final GlobalEventNotifier notifier;
  late final ProviderContainer container;
  late final CreateGlobalEventUseCaseMock createGlobalEventUseCaseMock;
  late final UpdateGlobalEventUseCaseMock updateGlobalEventUseCaseMock;
  late final SessionNotiferMock sessionNotiferMock;
  late final UploadImageUseCaseMock uploadImageUseCaseMock;
  late final GetGlobalEventByIdUseCaseMock getGlobalEventByIdUseCaseMock;
  late final GetAllGlobalEventsUseCaseMock getAllGlobalEventsUseCaseMock;
  late final GetDepartmentsUseCaseMock getDepartmentsUseCaseMock;
  late final GetProductsByCommerceUsecaseMock getProductsByCommerceUsecaseMock;

  setUpAll(() {
    createGlobalEventUseCaseMock = CreateGlobalEventUseCaseMock();
    updateGlobalEventUseCaseMock = UpdateGlobalEventUseCaseMock();
    uploadImageUseCaseMock = UploadImageUseCaseMock();
    sessionNotiferMock = SessionNotiferMock();
    getGlobalEventByIdUseCaseMock = GetGlobalEventByIdUseCaseMock();
    getAllGlobalEventsUseCaseMock = GetAllGlobalEventsUseCaseMock();
    getDepartmentsUseCaseMock = GetDepartmentsUseCaseMock();
    getProductsByCommerceUsecaseMock = GetProductsByCommerceUsecaseMock();

    notifier = GlobalEventNotifier(
        createUseCase: createGlobalEventUseCaseMock,
        updateUseCase: updateGlobalEventUseCaseMock,
        getByIdUseCase: getGlobalEventByIdUseCaseMock,
        getAllUseCase: getAllGlobalEventsUseCaseMock,
        uploadImageUseCase: uploadImageUseCaseMock,
        getDepartmentsUseCase: getDepartmentsUseCaseMock,
        getProductsByCommerceUsecase: getProductsByCommerceUsecaseMock,
        rolConfig: Rol(
            name: 'ADMINISTRADOR',
            id: 'ADMINISTRADOR',
            functionConfig: {
              'globalEvents': FunctionConfig(
                  functionName: 'globalEvents',
                  readData: true,
                  createData: true,
                  updateData: true,
                  enabled: true)
            },
            code: 'ADMINISTRADOR',
            enabled: true,
            rolEnableToCreate: ['ADMINISTRADOR']));

    container = ProviderContainer(overrides: [
      createGlobalEventUseCaseProvider
          .overrideWithValue(createGlobalEventUseCaseMock),
      updateGlobalEventUseCaseProvider
          .overrideWithValue(updateGlobalEventUseCaseMock),
      getGlobalEventByIdUseCaseProvider
          .overrideWithValue(getGlobalEventByIdUseCaseMock),
      getDepartmentsUseCaseProvider
          .overrideWithValue(getDepartmentsUseCaseMock),
      getAllProductsUseCaseProvider
          .overrideWithValue(getProductsByCommerceUsecaseMock),
      getAllGlobalEventsUseCaseProvider
          .overrideWithValue(getAllGlobalEventsUseCaseMock),
      sessionNotifierProvider.overrideWith((ref) => sessionNotiferMock),
      uploadImageUseCaseProvider.overrideWithValue(uploadImageUseCaseMock)
    ]);
    registerFallbackValue(Mocks.globalEventMock);
    when(() => createGlobalEventUseCaseMock.call(any()))
        .thenAnswer((_) async => {});
    when(() => updateGlobalEventUseCaseMock.call(any(), any()))
        .thenAnswer((_) async => {});
    when(() => getGlobalEventByIdUseCaseMock.call(any()))
        .thenAnswer((_) async => Mocks.globalEventMock);
    when(() => getDepartmentsUseCaseMock.call()).thenAnswer((_) async => [
          Department(
              name: 'ATLANTICO',
              cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])
        ]);
    when(() => uploadImageUseCaseMock.call(
        path: any(named: 'path'),
        bytes: any(named: 'bytes'),
        folder: any(named: 'folder'))).thenAnswer((_) async => '123456');
  });

  group('GlobalEventNotifier test', () {
    test('Verify provider of notifier', () async {
      final notifierState = container.read(globalEventNotifierProvider);
      expect(notifierState, isA<GlobalEventState>());
    });

    test('initial state', () {
      expect(notifier.state.isLoading, false);
    });

    test('validate init method invoke usecases', () async {
      when(() => getAllGlobalEventsUseCaseMock.call())
          .thenAnswer((_) async => [Mocks.globalEventMock]);
      await notifier.init();
      verify(
        () => getAllGlobalEventsUseCaseMock.call(),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Festival del perro caliente');
    });

    test('validate load all method invoke usecases', () async {
      when(() => getAllGlobalEventsUseCaseMock.call())
          .thenAnswer((_) async => [Mocks.globalEventMock]);
      await notifier.loadAll();
      expect(notifier.state.data[0]['name'], 'Festival del perro caliente');
    });

    test('validate error message when exception', () async {
      when(() => getAllGlobalEventsUseCaseMock.call())
          .thenThrow(Exception('ERROR'));
      await notifier.loadAll();
      expect(notifier.state.data, isEmpty);
      expect(notifier.state.errorMessage, isNotNull);
    });

    test('validate create method invoke usecases', () async {
      when(() => getAllGlobalEventsUseCaseMock.call())
          .thenAnswer((_) async => [Mocks.globalEventMock]);
      await notifier.create({
        'id': '1',
        'name': 'Festival del perro caliente',
        'description': 'Festival del perro caliente en la plaza de la paz',
        'location': MapLocationData(
          longitude: -74.789077,
          latitude: 10.987877,
          radious: 100,
        ),
        'scheduleDate': DateData(
            date: '05/05/2026', hour: '14:00', fullDate: '05/05/2026 14:00'),
        'startDate': '05/05/2026 12:00',
        'endDate': '05/05/2026 18:00',
        'status': 'PUBLICADO',
        'cityDepartment':
            CityData(city: 'BARRANQUILLA', department: 'ATLANTICO')
      });
      verify(
        () => createGlobalEventUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Festival del perro caliente');
    });

    test('validate update method invoke usecases', () async {
      when(() => getAllGlobalEventsUseCaseMock.call())
          .thenAnswer((_) async => [Mocks.globalEventMock]);

      await notifier.update('1', {
        'id': '1',
        'name': 'Festival del perro caliente',
        'description': 'Festival del perro caliente en la plaza de la paz',
        'location': MapLocationData(
          longitude: -74.789077,
          latitude: 10.987877,
          radious: 100,
        ),
        'scheduleDate': DateData(
            date: '05/05/2026', hour: '14:00', fullDate: '05/05/2026 14:00'),
        'startDate': '05/05/2026 12:00',
        'endDate': '05/05/2026 18:00',
        'status': 'PUBLICADO',
        'cityDepartment':
            CityData(city: 'BARRANQUILLA', department: 'ATLANTICO')
      });
      verify(
        () => updateGlobalEventUseCaseMock.call(any(), any()),
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
