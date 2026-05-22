import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/usecases/commerce/update_commerce_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CommerceRepositoryMock repository;
  late final UpdateCommerceUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CommerceRepositoryMock();
    useCase = UpdateCommerceUseCase(repository: repository);
    registerFallbackValue(Mocks.commerceMock);
    when(() => repository.update(any(), any()))
        .thenAnswer((_) async => '1234556785');
    container = ProviderContainer(
      overrides: [
        commerceRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('UpdateCommerceUseCase test', () {
    test('Invoke method in usecase UpdateCommerceUseCase', () async {
      await useCase.call('1', Mocks.commerceMock);
      verify(
        () => repository.update(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(updateCommerceUseCaseProvider);
      expect(usecaseInyected, isA<UpdateCommerceUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
