import 'package:delivery_app/data/repositories/product_repository_impl.dart';
import 'package:delivery_app/domain/usecases/product/create_product_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final ProductRepositoryMock repository;
  late final CreateProductUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = ProductRepositoryMock();
    useCase = CreateProductUseCase(repository: repository);
    registerFallbackValue(Mocks.productMock);
    when(() => repository.create(any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        productRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('CreateProductUseCase test', () {
    test('Invoke create method in usecase CreateProductUseCase', () async {
      await useCase.call(Mocks.productMock);
      verify(
        () => repository.create(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(createProductUseCaseProvider);
      expect(usecaseInyected, isA<CreateProductUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
