import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/usecases/checkout/update_status_checkout_order_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../repositories_mocks.dart';

void main() {
  late final CheckoutOrderRepositoryMock repository;
  late final UpdateStatusCheckoutOrderUsecase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CheckoutOrderRepositoryMock();
    useCase = UpdateStatusCheckoutOrderUsecase(repository: repository);
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

  group('UpdateStatusCheckoutOrderUsecase test', () {
    test('Invoke update method in usecase UpdateStatusCheckoutOrderUsecase',
        () async {
      await useCase.call('1', {});
      verify(
        () => repository.updateCheckoutStatus(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(updateStatusCheckoutOrderUsecaseProvider);
      expect(usecaseInyected, isA<UpdateStatusCheckoutOrderUsecase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
