import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/category/create_category_usecase.dart';
import 'package:delivery_app/domain/usecases/category/get_categories_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/category/update_category_usecase.dart';
import 'package:delivery_app/presentation/notifier/category/category_notifier.dart';
import 'package:delivery_app/presentation/notifier/category/category_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../mocks.dart';
import '../../../usecases_mocks.dart';

void main() {
  late final CategoryNotifier notifier;
  late final ProviderContainer container;
  late final CreateCategoryUseCaseMock createCategoryUseCaseMock;
  late final UpdateCategoryUseCaseMock updateCategoryUseCaseMock;
  late final GetCategoriesByCommerceUseCaseMock
      getCategoriesByCommerceUseCaseMock;
  late final SessionNotiferMock sessionNotiferMock;

  setUpAll(() {
    createCategoryUseCaseMock = CreateCategoryUseCaseMock();
    updateCategoryUseCaseMock = UpdateCategoryUseCaseMock();
    getCategoriesByCommerceUseCaseMock = GetCategoriesByCommerceUseCaseMock();
    sessionNotiferMock = SessionNotiferMock();

    notifier = CategoryNotifier(
        createUseCase: createCategoryUseCaseMock,
        updateUseCase: updateCategoryUseCaseMock,
        getCategoriesByCommerceUseCase: getCategoriesByCommerceUseCaseMock,
        commerceId: 'ABC123',
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
      createCategoryUseCaseProvider
          .overrideWithValue(createCategoryUseCaseMock),
      updateCategoryUseCaseProvider
          .overrideWithValue(updateCategoryUseCaseMock),
      getCategoriesByCommerceUseCaseProvider
          .overrideWithValue(getCategoriesByCommerceUseCaseMock),
      sessionNotifierProvider.overrideWith((ref) => sessionNotiferMock)
    ]);
    registerFallbackValue(Mocks.categoryMock);
    when(() => createCategoryUseCaseMock.call(any())).thenAnswer((_) async => {});
    when(() => updateCategoryUseCaseMock.call(any(), any())).thenAnswer((_) async => {});
    when(() => getCategoriesByCommerceUseCaseMock.call(any())).thenAnswer((_) async => [Mocks.categoryMock]);
  });

  group('CategoryNotifier test', () {
    test('Verify provider of notifier', () async {
      final notifierState = container.read(categoryNotifierProvider);
      expect(notifierState, isA<CategoryState>());
    });

    test('initial state', () {
      expect(notifier.state.isLoading, false);
    });

    test('validate init method invoke usecases', () async {
      await notifier.init();
      verify(
        () => getCategoriesByCommerceUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Hamburguesas');
    });

    test('validate init method invoke usecases', () async {
      await notifier.loadAll();
      expect(notifier.state.data[0]['name'], 'Hamburguesas');
    });

    test('validate error message when exception', () async {
      when(() => getCategoriesByCommerceUseCaseMock.call(any())).thenThrow(Exception('ERROR'));
      await notifier.loadAll();
      expect(notifier.state.data, isEmpty);
      expect(notifier.state.errorMessage, isNotNull);
    });

    test('validate create method invoke usecases', () async {
      when(() => getCategoriesByCommerceUseCaseMock.call(any())).thenAnswer((_) async => [Mocks.categoryMock]);
      await notifier.create(Mocks.mapCategoryMock);
      verify(
        () => createCategoryUseCaseMock.call(any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Hamburguesas');
    });

    test('validate update method invoke usecases', () async {
      when(() => getCategoriesByCommerceUseCaseMock.call(any())).thenAnswer((_) async => [Mocks.categoryMock]);

      await notifier.update('1', Mocks.mapCategoryMock);
      verify(
        () => updateCategoryUseCaseMock.call(any(), any()),
      ).called(1);
      expect(notifier.state.data[0]['name'], 'Hamburguesas');
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
