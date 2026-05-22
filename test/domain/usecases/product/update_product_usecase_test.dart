import 'package:delivery_app/data/repositories/product_repository_impl.dart';
import 'package:delivery_app/domain/usecases/product/update_product_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final ProductRepositoryMock repository;
  late final UpdateProductUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = ProductRepositoryMock();
    useCase = UpdateProductUseCase(repository: repository);
    registerFallbackValue(Mocks.productMock);
    when(() => repository.update(any(), any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        productRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('Update product use case test', () {
    test('Invoke update method in usecase UpdateProductUseCase', () async {
      await useCase.call('1', Mocks.productMock);
      verify(
        () => repository.update(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(updateProductUseCaseProvider);
      expect(usecaseInyected, isA<UpdateProductUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
