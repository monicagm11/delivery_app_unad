import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/event/update_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final LocalEventRepositoryMock repository;
  late final UpdateLocalEventUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = LocalEventRepositoryMock();
    useCase = UpdateLocalEventUseCase(repository: repository);
    registerFallbackValue(Mocks.localEventMock);
    when(() => repository.update(any(), any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        localEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('UpdateLocalEventUseCase test', () {
    test('Invoke update method in usecase UpdateLocalEventUseCase', () async {
      await useCase.call('1', Mocks.localEventMock);
      verify(
        () => repository.update(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(updateLocalEventUseCaseProvider);
      expect(usecaseInyected, isA<UpdateLocalEventUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
