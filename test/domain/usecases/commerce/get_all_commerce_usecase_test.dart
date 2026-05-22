import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/usecases/commerce/get_all_commercers_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CommerceRepositoryMock repository;
  late final GetAllCommercesUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CommerceRepositoryMock();
    useCase = GetAllCommercesUseCase(repository: repository);
    when(() => repository.getAll())
        .thenAnswer((_) async => [Mocks.commerceMock]);
    container = ProviderContainer(
      overrides: [
        commerceRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetAllCommercesUseCase test', () {
    test('Invoke method in usecase GetAllCommercesUseCase', () async {
      await useCase.call();
      verify(
        () => repository.getAll(),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getAllCommercesUseCaseProvider);
      expect(usecaseInyected, isA<GetAllCommercesUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
