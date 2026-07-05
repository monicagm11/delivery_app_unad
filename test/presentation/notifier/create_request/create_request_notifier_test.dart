import 'package:delivery_app/domain/entities/checkbox_option.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/create_request/create_request_event_usecase.dart';
import 'package:delivery_app/domain/usecases/create_request/get_request_events_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/create_request/update_request_event_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_all_global_events_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/presentation/notifier/create_request/create_request_notifier.dart';
import 'package:delivery_app/presentation/notifier/create_request/create_request_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../usecases_mocks.dart';

void main() {
  late final CreateRequestEventNotifier notifier;
  late final ProviderContainer container;
  late final CreateRequestEventUseCaseMock createCreateRequestEventUseCaseMock;
  late final UpdateRequestEventUseCaseMock updateCreateRequestEventUseCaseMock;
  late final SessionNotiferMock sessionNotiferMock;
  late final GetProductsByCommerceUsecaseMock getProductsByCommerceUsecaseMock;
  late final GetRequestEventsByCommerceUseCaseMock
      getRequestEventsByCommerceUseCaseMock;
  late final GetAllGlobalEventsUseCaseMock getAllGlobalEventsUseCaseMock;

  setUpAll(() {
    createCreateRequestEventUseCaseMock = CreateRequestEventUseCaseMock();
    updateCreateRequestEventUseCaseMock = UpdateRequestEventUseCaseMock();
    sessionNotiferMock = SessionNotiferMock();
    getProductsByCommerceUsecaseMock = GetProductsByCommerceUsecaseMock();
    getRequestEventsByCommerceUseCaseMock =
        GetRequestEventsByCommerceUseCaseMock();
    getAllGlobalEventsUseCaseMock = GetAllGlobalEventsUseCaseMock();

    notifier = CreateRequestEventNotifier(
        createUseCase: createCreateRequestEventUseCaseMock,
        updateUseCase: updateCreateRequestEventUseCaseMock,
        getAllUseCase: getRequestEventsByCommerceUseCaseMock,
        getProductsByCommerceUsecase: getProductsByCommerceUsecaseMock,
        getAllGlobalEventUsecase: getAllGlobalEventsUseCaseMock,
        commerceId: '123456',
        rolConfig: Rol(
            name: 'ADMINISTRADOR',
            id: 'ADMINISTRADOR',
            functionConfig: {
              'createRequestEvents': FunctionConfig(
                  functionName: 'createRequestEvents',
                  readData: true,
                  createData: true,
                  updateData: true,
                  enabled: true)
            },
            code: 'ADMINISTRADOR',
            enabled: true,
            rolEnableToCreate: ['ADMINISTRADOR']));

    container = ProviderContainer(overrides: [
      createRequestEventUseCaseProvider
          .overrideWithValue(createCreateRequestEventUseCaseMock),
      updateRequestEventUseCaseProvider
          .overrideWithValue(updateCreateRequestEventUseCaseMock),
      getRequestEventsByCommerceUseCaseProvider
          .overrideWithValue(getRequestEventsByCommerceUseCaseMock),
      getAllProductsUseCaseProvider
          .overrideWithValue(getProductsByCommerceUsecaseMock),
      getAllGlobalEventsUseCaseProvider
          .overrideWithValue(getAllGlobalEventsUseCaseMock),
      sessionNotifierProvider.overrideWith((ref) => sessionNotiferMock),
    ]);
    registerFallbackValue(Mocks.requestEventMock);
    when(() => createCreateRequestEventUseCaseMock.call(any()))
        .thenAnswer((_) async => {});
    when(() => updateCreateRequestEventUseCaseMock.call(any(), any()))
        .thenAnswer((_) async => {});
    when(() => getRequestEventsByCommerceUseCaseMock.call(any()))
        .thenAnswer((_) async => [Mocks.requestEventMock]);
    when(() => getProductsByCommerceUsecaseMock.call(any()))
        .thenAnswer((_) async => [Mocks.productMock]);
    when(() => getAllGlobalEventsUseCaseMock.call())
        .thenAnswer((_) async => [Mocks.globalEventMock]);
  });

  group('CreateRequestEventNotifier test', () {
    test('Verify provider of notifier', () async {
      final notifierState = container.read(createRequestEventNotifierProvider);
      expect(notifierState, isA<CreateRequestState>());
    });

    test('initial state', () {
      expect(notifier.state.isLoading, false);
    });

    test('validate init method invoke usecases', () async {
      when(() => getRequestEventsByCommerceUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.requestEventMock]);
      await notifier.init();
      verify(
        () => getAllGlobalEventsUseCaseMock.call(),
      ).called(1);
      expect(notifier.state.data[0]['eventId'], '1');
    });

    test('validate load all method invoke usecases', () async {
      when(() => getRequestEventsByCommerceUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.requestEventMock]);
      await notifier.loadAll();
      expect(notifier.state.data[0]['eventId'], '1');
    });

    test('validate error message when exception', () async {
      when(() => getRequestEventsByCommerceUseCaseMock.call(any()))
          .thenThrow(Exception('ERROR'));
      await notifier.loadAll();
      expect(notifier.state.data, isEmpty);
      expect(notifier.state.errorMessage, isNotNull);
    });

    test('validate create method invoke usecases', () async {
      when(() => getRequestEventsByCommerceUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.requestEventMock]);
      await notifier.create({
        'commerceId': 'ABCDE123',
        'status': 'ACTIVO',
        'event': Mocks.globalEventMock,
        'creationDate': '05/05/2026 12:00',
        'products': [CheckboxOption(label: 'label', value: 'DEF145')],
        'locationClientType': 'numberedChair'
      });
      verify(
        () => createCreateRequestEventUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['eventId'], '1');
    });

    test('validate update method invoke usecases', () async {
      when(() => getRequestEventsByCommerceUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.requestEventMock]);

      await notifier.update('1', {
        'id': 'ABC123DEF',
        'commerceId': 'ABCDE123',
        'status': 'ACTIVO',
        'event': Mocks.globalEventMock,
        'creationDate': '05/05/2026 12:00',
        'products': [CheckboxOption(label: 'label', value: 'DEF145')],
        'locationClientType': 'numberedChair'
      });
      verify(
        () => updateCreateRequestEventUseCaseMock.call(any(), any()),
      ).called(1);
      expect(notifier.state.data[0]['eventId'], '1');
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
