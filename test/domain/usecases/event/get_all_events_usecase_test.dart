import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/event/get_all_events_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final LocalEventRepositoryMock repository;
  late final GetAllLocalEventsUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = LocalEventRepositoryMock();
    useCase = GetAllLocalEventsUseCase(repository: repository);
    when(() => repository.getAll()).thenAnswer((_) async => [Mocks.localEventMock]);
    container = ProviderContainer(
      overrides: [
        localEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetAllLocalEventsUseCase test', () {
    test('Invoke update method in usecase GetAllLocalEventsUseCase', () async {
      await useCase.call();
      verify(
        () => repository.getAll(),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getAllLocalEventsUseCaseProvider);
      expect(usecaseInyected, isA<GetAllLocalEventsUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
