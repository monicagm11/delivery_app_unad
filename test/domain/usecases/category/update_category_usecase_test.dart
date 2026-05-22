import 'package:delivery_app/data/repositories/category_repository_impl.dart';
import 'package:delivery_app/domain/usecases/category/update_category_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CategoryRepositoryMock repository;
  late final UpdateCategoryUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CategoryRepositoryMock();
    useCase = UpdateCategoryUseCase(repository: repository);
    registerFallbackValue(Mocks.categoryMock);
    when(() => repository.update(any(), any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        categoryRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('Update category use case test', () {
    test('Invoke create method in usecase UpdateCategoryUseCase', () async {
      await useCase.call('1', Mocks.categoryMock);
      verify(
        () => repository.update(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(updateCategoryUseCaseProvider);
      expect(usecaseInyected, isA<UpdateCategoryUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
