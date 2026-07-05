import 'package:delivery_app/domain/entities/calculator_price_data.dart';
import 'package:delivery_app/domain/entities/image_data.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/category/get_categories_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/upload_image_usecase.dart';
import 'package:delivery_app/domain/usecases/product/create_product_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/product/update_product_usecase.dart';
import 'package:delivery_app/presentation/notifier/product/product_notifier.dart';
import 'package:delivery_app/presentation/notifier/product/product_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../usecases_mocks.dart';

void main() {
  late final ProductNotifier notifier;
  late final ProviderContainer container;
  late final CreateProductUseCaseMock createProductUseCaseMock;
  late final UpdateProductUseCaseMock updateProductUseCaseMock;
  late final GetProductsByCommerceUsecaseMock getProductsByCommerceUseCaseMock;
  late final SessionNotiferMock sessionNotiferMock;
  late final GetCategoriesByCommerceUseCaseMock
      getCategoriesByCommerceUseCaseMock;
  late final UploadImageUseCaseMock uploadImageUseCaseMock;

  setUpAll(() {
    createProductUseCaseMock = CreateProductUseCaseMock();
    updateProductUseCaseMock = UpdateProductUseCaseMock();
    getProductsByCommerceUseCaseMock = GetProductsByCommerceUsecaseMock();
    getCategoriesByCommerceUseCaseMock = GetCategoriesByCommerceUseCaseMock();
    uploadImageUseCaseMock = UploadImageUseCaseMock();
    sessionNotiferMock = SessionNotiferMock();

    notifier = ProductNotifier(
        createUseCase: createProductUseCaseMock,
        updateUseCase: updateProductUseCaseMock,
        getAllUseCase: getProductsByCommerceUseCaseMock,
        getCategoriesByCommerceUseCase: getCategoriesByCommerceUseCaseMock,
        uploadImageUseCase: uploadImageUseCaseMock,
        commerceId: 'ABC123',
        rolConfig: Rol(
            name: 'ADMINISTRADOR',
            id: 'ADMINISTRADOR',
            functionConfig: {
              'products': FunctionConfig(
                  functionName: 'products',
                  readData: true,
                  createData: true,
                  updateData: true,
                  enabled: true)
            },
            code: 'ADMINISTRADOR',
            enabled: true,
            rolEnableToCreate: ['ADMINISTRADOR']));

    container = ProviderContainer(overrides: [
      createProductUseCaseProvider.overrideWithValue(createProductUseCaseMock),
      updateProductUseCaseProvider.overrideWithValue(updateProductUseCaseMock),
      getAllProductsUseCaseProvider
          .overrideWithValue(getProductsByCommerceUseCaseMock),
      getCategoriesByCommerceUseCaseProvider
          .overrideWithValue(getCategoriesByCommerceUseCaseMock),
      sessionNotifierProvider.overrideWith((ref) => sessionNotiferMock),
      uploadImageUseCaseProvider.overrideWithValue(uploadImageUseCaseMock)
    ]);
    registerFallbackValue(Mocks.productMock);
    when(() => createProductUseCaseMock.call(any()))
        .thenAnswer((_) async => {});
    when(() => updateProductUseCaseMock.call(any(), any()))
        .thenAnswer((_) async => {});
    when(() => getProductsByCommerceUseCaseMock.call(any()))
        .thenAnswer((_) async => [Mocks.productMock]);
    when(() => getCategoriesByCommerceUseCaseMock.call(any()))
        .thenAnswer((_) async => [Mocks.categoryMock]);
    when(() => uploadImageUseCaseMock.call(
        path: any(named: 'path'),
        bytes: any(named: 'bytes'),
        folder: any(named: 'folder'))).thenAnswer((_) async => '123456');
  });

  group('ProductNotifier test', () {
    test('Verify provider of notifier', () async {
      final notifierState = container.read(productNotifierProvider);
      expect(notifierState, isA<ProductState>());
    });

    test('initial state', () {
      expect(notifier.state.isLoading, false);
    });

    test('validate init method invoke usecases', () async {
      await notifier.init();
      verify(
        () => getProductsByCommerceUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Hamburguesa de carne');
    });

    test('validate init method invoke usecases', () async {
      await notifier.loadAll();
      expect(notifier.state.data[0]['name'], 'Hamburguesa de carne');
    });

    test('validate error message when exception', () async {
      when(() => getProductsByCommerceUseCaseMock.call(any()))
          .thenThrow(Exception('ERROR'));
      await notifier.loadAll();
      expect(notifier.state.data, isEmpty);
      expect(notifier.state.errorMessage, isNotNull);
    });

    test('validate create method invoke usecases', () async {
      when(() => getProductsByCommerceUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.productMock]);
      await notifier.create({
        'name': 'Hamburguesa de carne',
        'price': CalculatorPriceData(
            ivaPercentage: 19,
            priceBase: 50000,
            ivaValue: 9500,
            priceTotal: 59500),
        'image': ImageData(folder: 'folder', path: 'path'),
        'category': '1',
        'time': '15 min',
        'status': 'ACTIVO',
        'commerce': 'ABCDE123',
        'description': 'Hamburguesa de carne y queso americano',
        'categoryName': 'Hamburguesas'
      });
      verify(
        () => createProductUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Hamburguesa de carne');
    });

    test('validate update method invoke usecases', () async {
      when(() => getProductsByCommerceUseCaseMock.call(any()))
          .thenAnswer((_) async => [Mocks.productMock]);

      await notifier.update('1', {
        'id': '1',
        'name': 'Hamburguesa de carne',
        'price': CalculatorPriceData(
            ivaPercentage: 19,
            priceBase: 50000,
            ivaValue: 9500,
            priceTotal: 59500),
        'image': ImageData(folder: 'folder', path: 'path'),
        'category': '1',
        'time': '15 min',
        'status': 'ACTIVO',
        'commerce': 'ABCDE123',
        'description': 'Hamburguesa de carne y queso americano',
        'categoryName': 'Hamburguesas'
      });
      verify(
        () => updateProductUseCaseMock.call(any(), any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Hamburguesa de carne');
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
