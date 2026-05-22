import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/event/get_event_by_city_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final LocalEventRepositoryMock repository;
  late final GetEventByCityUsecase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = LocalEventRepositoryMock();
    useCase = GetEventByCityUsecase(repository: repository);
    when(() => repository.getActiveByCity(any(), any())).thenAnswer((_) async => [Mocks.localEventMock]);
    container = ProviderContainer(
      overrides: [
        localEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetAllLocalEventsUseCase test', () {
    test('Invoke update method in usecase GetEventByCityUsecase', () async {
      await useCase.call('BARRANQUILLA', 'ATLANTICO');
      verify(
        () => repository.getActiveByCity(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getEventByCityUseCaseProvider);
      expect(usecaseInyected, isA<GetEventByCityUsecase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
