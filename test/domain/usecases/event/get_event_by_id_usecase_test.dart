import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/event/get_event_by_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final LocalEventRepositoryMock repository;
  late final GetLocalEventByIdUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = LocalEventRepositoryMock();
    useCase = GetLocalEventByIdUseCase(repository: repository);
    when(() => repository.getById(any())).thenAnswer((_) async => Mocks.localEventMock);
    container = ProviderContainer(
      overrides: [
        localEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetLocalEventByIdUseCase test', () {
    test('Invoke update method in usecase GetLocalEventByIdUseCase', () async {
      await useCase.call('1');
      verify(
        () => repository.getById(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getLocalEventByIdUseCaseProvider);
      expect(usecaseInyected, isA<GetLocalEventByIdUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
