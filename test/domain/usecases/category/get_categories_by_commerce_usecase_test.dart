import 'package:delivery_app/data/repositories/category_repository_impl.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/usecases/category/get_categories_by_commerce_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CategoryRepositoryMock repository;
  late final GetCategoriesByCommerceUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CategoryRepositoryMock();
    useCase = GetCategoriesByCommerceUseCase(repository: repository);
    when(() => repository.getByCommerce(any()))
        .thenAnswer((_) async => [Mocks.categoryMock]);

    container = ProviderContainer(
      overrides: [
        categoryRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetCategoriesByCommerceUseCase test', () {
    test('Invoke create method in usecase GetCategoriesByCommerceUseCase',
        () async {
      List<Category> list = await useCase.call('1');
      expect(list.length, 1);
      verify(
        () => repository.getByCommerce(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(getCategoriesByCommerceUseCaseProvider);
      expect(usecaseInyected, isA<GetCategoriesByCommerceUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
