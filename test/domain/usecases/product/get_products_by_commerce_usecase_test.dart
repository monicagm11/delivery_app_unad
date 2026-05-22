import 'package:delivery_app/data/repositories/product_repository_impl.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final ProductRepositoryMock repository;
  late final GetProductsByCommerceUsecase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = ProductRepositoryMock();
    useCase = GetProductsByCommerceUsecase(repository: repository);
    when(() => repository.getByCommerce(any())).thenAnswer((_) async => [Mocks.productMock]);

    container = ProviderContainer(
      overrides: [
        productRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetProductsByCommerceUsecase test', () {
    test('Invoke method in usecase GetProductsByCommerceUsecase', () async {
      await useCase.call('1');
      verify(
        () => repository.getByCommerce(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getAllProductsUseCaseProvider);
      expect(usecaseInyected, isA<GetProductsByCommerceUsecase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}