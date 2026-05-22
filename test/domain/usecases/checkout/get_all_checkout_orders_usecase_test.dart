import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/usecases/checkout/get_all_checkout_order_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CheckoutOrderRepositoryMock repository;
  late final GetAllCheckoutOrdersUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CheckoutOrderRepositoryMock();
    useCase = GetAllCheckoutOrdersUseCase(repository: repository);
    when(() => repository.getAll())
        .thenAnswer((_) async => [Mocks.checkoutOrderMock]);

    container = ProviderContainer(
      overrides: [
        checkoutOrderRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetAllCheckoutOrdersUseCase test', () {
    test('Invoke method in usecase GetAllCheckoutOrdersUseCase', () async {
      List<CheckoutOrder> list = await useCase.call();
      expect(list.length, 1);
      verify(
        () => repository.getAll(),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(getAllCheckoutOrdersUseCaseProvider);
      expect(usecaseInyected, isA<GetAllCheckoutOrdersUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
