import 'package:delivery_app/data/repositories/category_repository_impl.dart';
import 'package:delivery_app/domain/usecases/category/create_category_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CategoryRepositoryMock repository;
  late final CreateCategoryUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CategoryRepositoryMock();
    useCase = CreateCategoryUseCase(repository: repository);
    registerFallbackValue(Mocks.categoryMock);
    when(() => repository.create(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        categoryRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('CreateCategoryUseCase test', () {
    test('Invoke create method in usecase CreateCategoryUseCase', () async {
      await useCase.call(Mocks.categoryMock);
      verify(
        () => repository.create(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(createCategoryUseCaseProvider);
      expect(usecaseInyected, isA<CreateCategoryUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
