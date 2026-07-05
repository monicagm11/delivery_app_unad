import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:delivery_app/domain/entities/image_data.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/commerce/create_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_all_commercers_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/update_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/upload_image_usecase.dart';
import 'package:delivery_app/presentation/notifier/commerce/commerce_notifier.dart';
import 'package:delivery_app/presentation/notifier/commerce/commerce_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../usecases_mocks.dart';

void main() {
  late final CommerceNotifier notifier;
  late final ProviderContainer container;
  late final CreateCommerceUseCaseMock createCommerceUseCaseMock;
  late final UpdateCommerceUseCaseMock updateCommerceUseCaseMock;
  late final GetAllCommercesUseCaseMock getAllCommercesUseCaseMock;
  late final UploadImageUseCaseMock uploadImageUseCaseMock;
  late final GetCommerceByIdUseCaseMock getCommerceByIdUseCaseMock;
  late final GetDepartmentsUseCaseMock getDepartmentsUseCaseMock;
  late final SessionNotiferMock sessionNotiferMock;

  setUpAll(() {
    createCommerceUseCaseMock = CreateCommerceUseCaseMock();
    updateCommerceUseCaseMock = UpdateCommerceUseCaseMock();
    getAllCommercesUseCaseMock = GetAllCommercesUseCaseMock();
    uploadImageUseCaseMock = UploadImageUseCaseMock();
    getCommerceByIdUseCaseMock = GetCommerceByIdUseCaseMock();
    getDepartmentsUseCaseMock = GetDepartmentsUseCaseMock();
    sessionNotiferMock = SessionNotiferMock();

    notifier = CommerceNotifier(
        createUseCase: createCommerceUseCaseMock,
        updateUseCase: updateCommerceUseCaseMock,
        getAllUseCase: getAllCommercesUseCaseMock,
        uploadImageUseCase: uploadImageUseCaseMock,
        getByIdUseCase: getCommerceByIdUseCaseMock,
        getDepartmentsUseCase: getDepartmentsUseCaseMock,
        rolConfig: Rol(
            name: 'ADMINISTRADOR',
            id: 'ADMINISTRADOR',
            functionConfig: {
              'categories': FunctionConfig(
                  functionName: 'categories',
                  readData: true,
                  createData: true,
                  updateData: true,
                  enabled: true)
            },
            code: 'ADMINISTRADOR',
            enabled: true,
            rolEnableToCreate: ['ADMINISTRADOR']));

    container = ProviderContainer(overrides: [
      createCommerceUseCaseProvider
          .overrideWithValue(createCommerceUseCaseMock),
      updateCommerceUseCaseProvider
          .overrideWithValue(updateCommerceUseCaseMock),
      getCommerceByIdUseCaseProvider.overrideWithValue(getCommerceByIdUseCaseMock),
      getAllCommercesUseCaseProvider.overrideWithValue(getAllCommercesUseCaseMock),
      uploadImageUseCaseProvider.overrideWithValue(uploadImageUseCaseMock),
      getCommerceByIdUseCaseProvider.overrideWithValue(getCommerceByIdUseCaseMock),
      getDepartmentsUseCaseProvider.overrideWithValue(getDepartmentsUseCaseMock),
      sessionNotifierProvider.overrideWith((ref) => sessionNotiferMock)
    ]);
    registerFallbackValue(Mocks.commerceMock);
    when(() => createCommerceUseCaseMock.call(any())).thenAnswer((_) async => {});
    when(() => updateCommerceUseCaseMock.call(any(), any())).thenAnswer((_) async => {});
    when(() => getAllCommercesUseCaseMock.call()).thenAnswer((_) async => [Mocks.commerceMock]);
    when(() => getCommerceByIdUseCaseMock.call(any())).thenAnswer((_) async => Mocks.commerceMock);
    when(() => getDepartmentsUseCaseMock.call()).thenAnswer((_) async => [Department(name: 'ATLANTICO', cities: ['BARRANQUILLA', 'PUERTO COLOMBIA', 'SUAN'])]);
    when(() => uploadImageUseCaseMock.call(
        path: any(named: 'path'),
        bytes: any(named: 'bytes'),
        folder: any(named: 'folder'))).thenAnswer((_) async => '123456');
  });

  group('CommerceNotifier test', () {
    test('Verify provider of notifier', () async {
      final notifierState = container.read(commerceNotifierProvider);
      expect(notifierState, isA<CommerceState>());
    });

    test('initial state', () {
      expect(notifier.state.isLoading, false);
    });

    test('validate init method invoke usecases', () async {
      await notifier.init();
      verify(
        () => getDepartmentsUseCaseMock.call(),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Pizzeria MyG');
    });

    test('validate init method invoke usecases', () async {
      await notifier.loadAll();
      expect(notifier.state.data[0]['name'], 'Pizzeria MyG');
    });

    test('validate error message when exception', () async {
      when(() => getAllCommercesUseCaseMock.call()).thenThrow(Exception('ERROR'));
      await notifier.loadAll();
      expect(notifier.state.data, isEmpty);
      expect(notifier.state.errorMessage, isNotNull);
    });

    test('validate create method invoke usecases', () async {
      when(() => getAllCommercesUseCaseMock.call()).thenAnswer((_) async => [Mocks.commerceMock]);
      await notifier.create({
      'name': 'Pizzeria MyG',
      'status': 'ACTIVO',
      'fullDocument': 'NIT 123456',
      'identificationType': 'NIT',
      'document': '123456',
      'phone': '3001234567',
      'address': 'CL 1 2-3',
      'email': 'ejemplo@gmail.com',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'contactName': 'Samanta Collazos',
      'urlImage': ImageData(folder: 'folder', path: 'path'),
      'urlImageQR': ImageData(folder: 'folder', path: 'path'),
      'identification': IdentificationData(code: 'CC', number: '123456'),
      'cityDepartment': CityData(city: 'BARRANQUILLA', department: 'ATLANTICO')
      });
      verify(
        () => createCommerceUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Pizzeria MyG');
    });

    test('validate update method invoke usecases', () async {
      when(() => getAllCommercesUseCaseMock.call()).thenAnswer((_) async => [Mocks.commerceMock]);

      await notifier.update('1', {
        'id': 'ADGF234',
      'name': 'Pizzeria MyG',
      'status': 'ACTIVO',
      'fullDocument': 'NIT 123456',
      'identificationType': 'NIT',
      'document': '123456',
      'phone': '3001234567',
      'address': 'CL 1 2-3',
      'email': 'ejemplo@gmail.com',
      'department': 'ATLANTICO',
      'city': 'BARRANQUILLA',
      'contactName': 'Samanta Collazos',
      'urlImage': ImageData(folder: 'folder', path: 'path'),
      'urlImageQR': ImageData(folder: 'folder', path: 'path'),
      'identification': IdentificationData(code: 'CC', number: '123456'),
      'cityDepartment': CityData(city: 'BARRANQUILLA', department: 'ATLANTICO')
      });
      verify(
        () => updateCommerceUseCaseMock.call(any(), any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Pizzeria MyG');
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
