import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/rol_data.dart';
import 'package:delivery_app/domain/usecases/commerce/get_all_commercers_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/send_email_new_users_usecase.dart';
import 'package:delivery_app/domain/usecases/user/create_user_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_all_user_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/user/update_user_usecase.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/notifier/user/user_notifier.dart';
import 'package:delivery_app/presentation/notifier/user/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../usecases_mocks.dart';

void main() {
  late final UserNotifier notifier;
  late final ProviderContainer container;
  late final CreateUserUseCaseMock createUserUseCaseMock;
  late final UpdateUserUseCaseMock updateUserUseCaseMock;
  late final GetAllUsersUseCaseMock getAllUsersUseCaseMock;
  late final UploadImageUseCaseMock uploadImageUseCaseMock;
  late final GetUserByIdUseCaseMock getUserByIdUseCaseMock;
  late final GetDepartmentsUseCaseMock getDepartmentsUseCaseMock;
  late final GetAllCommercesUseCaseMock getAllCommercesUseCaseMock;
  late final SendEmailNewUsersUsecaseMock sendEmailNewUsersUsecaseMock;
  late final SessionNotiferMock sessionNotiferMock;

  setUpAll(() {
    createUserUseCaseMock = CreateUserUseCaseMock();
    updateUserUseCaseMock = UpdateUserUseCaseMock();
    getAllUsersUseCaseMock = GetAllUsersUseCaseMock();
    uploadImageUseCaseMock = UploadImageUseCaseMock();
    getUserByIdUseCaseMock = GetUserByIdUseCaseMock();
    getDepartmentsUseCaseMock = GetDepartmentsUseCaseMock();
    getAllCommercesUseCaseMock = GetAllCommercesUseCaseMock();
    sendEmailNewUsersUsecaseMock = SendEmailNewUsersUsecaseMock();
    sessionNotiferMock = SessionNotiferMock();

    notifier = UserNotifier(
        createUseCase: createUserUseCaseMock,
        updateUseCase: updateUserUseCaseMock,
        getAllUseCase: getAllUsersUseCaseMock,
        getAllCommercesUseCase: getAllCommercesUseCaseMock,
        getDepartmentsUseCase: getDepartmentsUseCaseMock,
        sendEmailNewUsersUsecase: sendEmailNewUsersUsecaseMock,
        commerceId: '123456',
        rolConfig: Rol(
            name: 'ADMINISTRADOR',
            id: 'ADMINISTRADOR',
            functionConfig: {
              'users': FunctionConfig(
                  functionName: 'users',
                  readData: true,
                  createData: true,
                  updateData: true,
                  enabled: true)
            },
            code: 'ADMINISTRADOR',
            enabled: true,
            rolEnableToCreate: ['ADMINISTRADOR']));

    container = ProviderContainer(overrides: [
      createUserUseCaseProvider.overrideWithValue(createUserUseCaseMock),
      updateUserUseCaseProvider.overrideWithValue(updateUserUseCaseMock),
      getUserByIdUseCaseProvider.overrideWithValue(getUserByIdUseCaseMock),
      getAllUsersUseCaseProvider.overrideWithValue(getAllUsersUseCaseMock),
      getUserByIdUseCaseProvider.overrideWithValue(getUserByIdUseCaseMock),
      getAllCommercesUseCaseProvider
          .overrideWithValue(getAllCommercesUseCaseMock),
      getDepartmentsUseCaseProvider
          .overrideWithValue(getDepartmentsUseCaseMock),
      sendEmailNewUsersUseCaseProvider
          .overrideWithValue(sendEmailNewUsersUsecaseMock),
      sessionNotifierProvider.overrideWith((ref) => sessionNotiferMock)
    ]);
    registerFallbackValue(Mocks.userMock);
    when(() => createUserUseCaseMock.call(any())).thenAnswer((_) async => {});
    when(() => updateUserUseCaseMock.call(any(), any()))
        .thenAnswer((_) async => {});
    when(() => getAllCommercesUseCaseMock.call())
        .thenAnswer((_) async => [Mocks.commerceMock]);
    when(() => getAllUsersUseCaseMock.call())
        .thenAnswer((_) async => [Mocks.userMock]);
    when(() => getUserByIdUseCaseMock.call(any()))
        .thenAnswer((_) async => Mocks.userMock);
    when(() => getDepartmentsUseCaseMock.call()).thenAnswer((_) async => [
          Department(
              name: 'ATLANTICO',
              cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])
        ]);
    when(() => uploadImageUseCaseMock.call(
        path: any(named: 'path'),
        bytes: any(named: 'bytes'),
        folder: any(named: 'folder'))).thenAnswer((_) async => '123456');
    when(() => sendEmailNewUsersUsecaseMock.call(
        email: any(named: 'email'),
        name: any(named: 'name'))).thenAnswer((_) async => '123456');
  });

  group('UserNotifier test', () {
    test('Verify provider of notifier', () async {
      final notifierState = container.read(userNotifierProvider);
      expect(notifierState, isA<UserState>());
    });

    test('initial state', () {
      expect(notifier.state.isLoading, false);
    });

    test('validate init method invoke usecases', () async {
      await notifier.init();
      verify(
        () => getDepartmentsUseCaseMock.call(),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Maria');
    });

    test('validate init method invoke usecases', () async {
      await notifier.loadAll();
      expect(notifier.state.data[0]['name'], 'Maria');
    });

    test('validate error message when exception', () async {
      when(() => getAllUsersUseCaseMock.call()).thenThrow(Exception('ERROR'));
      await notifier.loadAll();
      expect(notifier.state.data, isEmpty);
      expect(notifier.state.errorMessage, isNotNull);
    });

    test('validate create method invoke usecases', () async {
      when(() => getAllUsersUseCaseMock.call())
          .thenAnswer((_) async => [Mocks.userMock]);
      await notifier.create({
        'name': 'Maria',
        'lastname': 'Suarez',
        'fullname': 'Maria Suarez',
        'phone': '3000010203',
        'email': 'mariasuarez@ejemplo.com',
        'address': 'CL 11 11 11',
        'commerce': 'ABCDE123',
        'occupation': 'Administrador general',
        'currentEventId': '1',
        'token': 'nfiergbseifgre3y443rsb73ehsb',
        'userId': 'POIU908',
        'status': 'ACTIVO',
        'rol': RolData(rol: 'ADMINISTRADOR'),
        'identification': IdentificationData(code: 'CC', number: '123456'),
        'cityDepartment':
            CityData(city: 'BARRANQUILLA', department: 'ATLANTICO')
      });
      verify(
        () => createUserUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Maria');
    });

    test('validate update method invoke usecases', () async {
      when(() => getAllUsersUseCaseMock.call())
          .thenAnswer((_) async => [Mocks.userMock]);

      await notifier.update('1', {
        'id': 'POIU908',
        'name': 'Maria',
        'lastname': 'Suarez',
        'fullname': 'Maria Suarez',
        'phone': '3000010203',
        'email': 'mariasuarez@ejemplo.com',
        'address': 'CL 11 11 11',
        'commerce': 'ABCDE123',
        'occupation': 'Administrador general',
        'currentEventId': '1',
        'token': 'nfiergbseifgre3y443rsb73ehsb',
        'userId': 'POIU908',
        'status': 'ACTIVO',
        'rol': RolData(rol: 'ADMINISTRADOR'),
        'identification': IdentificationData(code: 'CC', number: '123456'),
        'cityDepartment':
            CityData(city: 'BARRANQUILLA', department: 'ATLANTICO')
      });
      verify(
        () => updateUserUseCaseMock.call(any(), any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Maria');
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
