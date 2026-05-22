import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/global_event/create_global_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final GlobalEventRepositoryMock repository;
  late final CreateGlobalEventUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = GlobalEventRepositoryMock();
    useCase = CreateGlobalEventUseCase(repository: repository);
    registerFallbackValue(Mocks.globalEventMock);
    when(() => repository.create(any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        globalEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('CreateGlobalEventUseCase test', () {
    test('Invoke method in usecase CreateGlobalEventUseCase', () async {
      await useCase.call(Mocks.globalEventMock);
      verify(
        () => repository.create(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(createGlobalEventUseCaseProvider);
      expect(usecaseInyected, isA<CreateGlobalEventUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
