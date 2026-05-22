import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/global_event/get_all_global_events_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final GlobalEventRepositoryMock repository;
  late final GetAllGlobalEventsUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = GlobalEventRepositoryMock();
    useCase = GetAllGlobalEventsUseCase(repository: repository);

    when(() => repository.getAll()).thenAnswer((_) async => [Mocks.globalEventMock]);
    container = ProviderContainer(
      overrides: [
        globalEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetAllGlobalEventsUseCase test', () {
    test('Invoke method in usecase GetAllGlobalEventsUseCase', () async {
      await useCase();
      verify(
        () => repository.getAll(),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getAllGlobalEventsUseCaseProvider);
      expect(usecaseInyected, isA<GetAllGlobalEventsUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
