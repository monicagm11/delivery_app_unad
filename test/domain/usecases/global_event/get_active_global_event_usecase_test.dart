import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/global_event/get_active_global_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final GlobalEventRepositoryMock repository;
  late final GetActiveGlobalEventUsecase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = GlobalEventRepositoryMock();
    useCase = GetActiveGlobalEventUsecase(repository: repository);

    when(() => repository.getAllActive()).thenAnswer((_) async => [Mocks.globalEventMock]);
    container = ProviderContainer(
      overrides: [
        globalEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetActiveGlobalEventUsecase test', () {
    test('Invoke method in usecase GetActiveGlobalEventUsecase', () async {
      await useCase();
      verify(
        () => repository.getAllActive(),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getActiveGlobalEventsUseCaseProvider);
      expect(usecaseInyected, isA<GetActiveGlobalEventUsecase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
