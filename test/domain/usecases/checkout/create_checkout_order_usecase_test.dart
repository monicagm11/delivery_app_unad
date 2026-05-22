import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/usecases/checkout/create_checkout_order_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CheckoutOrderRepositoryMock repository;
  late final CreateCheckoutOrderUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CheckoutOrderRepositoryMock();
    useCase = CreateCheckoutOrderUseCase(repository: repository);
    registerFallbackValue(Mocks.checkoutOrderMock);
    when(() => repository.create(any())).thenAnswer((_) async => '1234556785');

    container = ProviderContainer(
      overrides: [
        checkoutOrderRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('CreateCheckoutOrderUseCase test', () {
    test('Invoke create method in usecase CreateCheckoutOrderUseCase',
        () async {
      await useCase.call(Mocks.checkoutOrderMock);
      verify(
        () => repository.create(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(createCheckoutOrderUseCaseProvider);
      expect(usecaseInyected, isA<CreateCheckoutOrderUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
