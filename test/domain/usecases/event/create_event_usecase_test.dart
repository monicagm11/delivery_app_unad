import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/event/create_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final LocalEventRepositoryMock repository;
  late final CreateLocalEventUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = LocalEventRepositoryMock();
    useCase = CreateLocalEventUseCase(repository: repository);
    registerFallbackValue(Mocks.localEventMock);
    when(() => repository.create(any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        localEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('CreateLocalEventUseCase test', () {
    test('Invoke create method in usecase CreateLocalEventUseCase', () async {
      await useCase.call(Mocks.localEventMock);
      verify(
        () => repository.create(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(createLocalEventUseCaseProvider);
      expect(usecaseInyected, isA<CreateLocalEventUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
