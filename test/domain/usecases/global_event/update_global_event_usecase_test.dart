import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/global_event/update_global_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final GlobalEventRepositoryMock repository;
  late final UpdateGlobalEventUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = GlobalEventRepositoryMock();
    useCase = UpdateGlobalEventUseCase(repository: repository);
    registerFallbackValue(Mocks.globalEventMock);
    when(() => repository.update(any(), any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        globalEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('UpdateGlobalEventUseCase test', () {
    test('Invoke update method in usecase UpdateGlobalEventUseCase', () async {
      await useCase.call('1', Mocks.globalEventMock);
      verify(
        () => repository.update(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(updateGlobalEventUseCaseProvider);
      expect(usecaseInyected, isA<UpdateGlobalEventUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
