import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/usecases/checkout/get_checkout_orders_by_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CheckoutOrderRepositoryMock repository;
  late final GetCheckoutOrdersByEventUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CheckoutOrderRepositoryMock();
    useCase = GetCheckoutOrdersByEventUseCase(repository: repository);
    when(() => repository.getByEvent(any()))
        .thenAnswer((_) async => [Mocks.checkoutOrderMock]);
    container = ProviderContainer(
        overrides: [
          checkoutOrderRepositoryProvider.overrideWithValue(
            repository,
          ),
        ],
      );
  });

  group('GetCheckoutOrdersByEventUseCase test', () {
    test('Invoke method in usecase GetCheckoutOrdersByEventUseCase', () async {
      List<CheckoutOrder> list = await useCase.call('1');
      expect(list.length, 1);
      verify(
        () => repository.getByEvent(any()),
      ).called(1);
      
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(getCheckoutOrdersByEventUseCaseProvider);
      expect(usecaseInyected, isA<GetCheckoutOrdersByEventUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
