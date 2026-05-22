import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/usecases/checkout/get_checkout_orders_by_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CheckoutOrderRepositoryMock repository;
  late final GetCheckoutOrdersByUserUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CheckoutOrderRepositoryMock();
    useCase = GetCheckoutOrdersByUserUseCase(repository: repository);
    when(() => repository.getByUser(any()))
        .thenAnswer((_) async => [Mocks.checkoutOrderMock]);
    container = ProviderContainer(
      overrides: [
        checkoutOrderRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetCheckoutOrdersByUserUseCase test', () {
    test('Invoke create method in usecase GetCheckoutOrdersByUserUseCase',
        () async {
      List<CheckoutOrder> list = await useCase.call('1');
      expect(list.length, 1);
      verify(
        () => repository.getByUser(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(getCheckoutOrdersByUserUseCaseProvider);
      expect(usecaseInyected, isA<GetCheckoutOrdersByUserUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
