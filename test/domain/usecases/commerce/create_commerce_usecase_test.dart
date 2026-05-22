import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/usecases/commerce/create_commerce_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CommerceRepositoryMock repository;
  late final CreateCommerceUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CommerceRepositoryMock();
    useCase = CreateCommerceUseCase(repository: repository);
    registerFallbackValue(Mocks.commerceMock);
    when(() => repository.create(any())).thenAnswer((_) async => '1234556785');
    container = ProviderContainer(
      overrides: [
        commerceRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('CreateCommerceUseCase test', () {
    test('Invoke method in usecase CreateCommerceUseCase', () async {
      await useCase.call(Mocks.commerceMock);
      verify(
        () => repository.create(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(createCommerceUseCaseProvider);
      expect(usecaseInyected, isA<CreateCommerceUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
