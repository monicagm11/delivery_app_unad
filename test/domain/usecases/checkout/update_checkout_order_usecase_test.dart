import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/usecases/checkout/update_checkout_order_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CheckoutOrderRepositoryMock repository;
  late final UpdateCheckoutOrderUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CheckoutOrderRepositoryMock();
    useCase = UpdateCheckoutOrderUseCase(repository: repository);
    registerFallbackValue(Mocks.checkoutOrderMock);
    when(() => repository.update(any(), any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        checkoutOrderRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('UpdateCheckoutOrderUseCase test', () {
    test('Invoke update method in usecase UpdateCheckoutOrderUseCase',
        () async {
      await useCase.call('1', Mocks.checkoutOrderMock);
      verify(
        () => repository.update(any(), any()),
      ).called(1);
    });
    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(updateCheckoutOrderUseCaseProvider);
      expect(usecaseInyected, isA<UpdateCheckoutOrderUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
