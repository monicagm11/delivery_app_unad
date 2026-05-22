import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/usecases/user/update_current_event_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../repositories_mocks.dart';

void main() {
  late final UserRepositoryMock repository;
  late final UpdateCurrentEventIdUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = UserRepositoryMock();
    useCase = UpdateCurrentEventIdUseCase(repository: repository);
    when(() => repository.updateCurrentEventId(any(), any()))
        .thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('UpdateCurrentEventIdUseCase test', () {
    test('Invoke create method in usecase UpdateCurrentEventIdUseCase',
        () async {
      await useCase.call('ADFG567', '1');
      verify(
        () => repository.updateCurrentEventId(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(updateCurrentEventIdUseCaseProvider);
      expect(usecaseInyected, isA<UpdateCurrentEventIdUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
