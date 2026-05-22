import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/usecases/checkout/add_stage_to_checkout_order_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../repositories_mocks.dart';

void main() {
  late final CheckoutOrderRepositoryMock repository;
  late final AddStageToCheckoutOrderUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CheckoutOrderRepositoryMock();
    useCase = AddStageToCheckoutOrderUseCase(repository: repository);
    when(() => repository.updateCheckoutStatus(any(), any()))
        .thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        checkoutOrderRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('AddStageToCheckoutOrderUseCase test', () {
    test('Invoke update method in usecase AddStageToCheckoutOrderUseCase',
        () async {
      await useCase.call('1', TrackingStage(name: 'Pedido creado'));
      verify(
        () => repository.updateCheckoutStatus(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(addStageToCheckoutOrderUseCaseProvider);
      expect(usecaseInyected, isA<AddStageToCheckoutOrderUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
