import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/usecases/checkout/get_checkout_order_by_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CheckoutOrderRepositoryMock repository;
  late final GetCheckoutOrderByIdUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CheckoutOrderRepositoryMock();
    useCase = GetCheckoutOrderByIdUseCase(repository: repository);
    when(() => repository.getById(any()))
        .thenAnswer((_) async => Mocks.checkoutOrderMock);

    container = ProviderContainer(
      overrides: [
        checkoutOrderRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetCheckoutOrderByIdUseCase test', () {
    test('Invoke create method in usecase GetCheckoutOrderByIdUseCase',
        () async {
      CheckoutOrder? model = await useCase.call('1');
      expect(model, isNotNull);
      verify(
        () => repository.getById(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(getCheckoutOrderByIdUseCaseProvider);
      expect(usecaseInyected, isA<GetCheckoutOrderByIdUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
