import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final CommerceRepositoryMock repository;
  late final GetCommerceByIdUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = CommerceRepositoryMock();
    useCase = GetCommerceByIdUseCase(repository: repository);
    when(() => repository.getById(any()))
        .thenAnswer((_) async => Mocks.commerceMock);
    container = ProviderContainer(
      overrides: [
        commerceRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetCommerceByIdUseCase test', () {
    test('Invoke method in usecase GetCommerceByIdUseCase', () async {
      await useCase.call('1');
      verify(
        () => repository.getById(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getCommerceByIdUseCaseProvider);
      expect(usecaseInyected, isA<GetCommerceByIdUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
