import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/create_request/get_all_request_event_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final RequestEventRepositoryMock repository;
  late final GetAllRequestEventsUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = RequestEventRepositoryMock();
    useCase = GetAllRequestEventsUseCase(repository: repository);
    when(() => repository.getAll()).thenAnswer((_) async => [Mocks.requestEventMock]);
    container = ProviderContainer(
      overrides: [
        requestEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetAllRequestEventsUseCase test', () {
    test('Invoke method in usecase GetAllRequestEventsUseCase', () async {
      await useCase.call();
      verify(
        () => repository.getAll(),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getAllRequestEventsUseCaseProvider);
      expect(usecaseInyected, isA<GetAllRequestEventsUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
