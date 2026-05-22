import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/create_request/create_request_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final RequestEventRepositoryMock repository;
  late final CreateRequestEventUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = RequestEventRepositoryMock();
    useCase = CreateRequestEventUseCase(repository: repository);
    registerFallbackValue(Mocks.requestEventMock);
    when(() => repository.create(any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        requestEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('CreateRequestEventUseCase test', () {
    test('Invoke method in usecase CreateRequestEventUseCase', () async {
      await useCase.call(Mocks.requestEventMock);
      verify(
        () => repository.create(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(createRequestEventUseCaseProvider);
      expect(usecaseInyected, isA<CreateRequestEventUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
