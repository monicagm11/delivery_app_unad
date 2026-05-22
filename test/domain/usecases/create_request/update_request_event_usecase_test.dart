import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/create_request/update_request_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final RequestEventRepositoryMock repository;
  late final UpdateRequestEventUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = RequestEventRepositoryMock();
    useCase = UpdateRequestEventUseCase(repository: repository);
    registerFallbackValue(Mocks.requestEventMock);
    when(() => repository.update(any(), any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        requestEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('Update localEvent use case test', () {
    test('Invoke method in usecase UpdateRequestEventUseCase', () async {
      await useCase.call('1', Mocks.requestEventMock);
      verify(
        () => repository.update(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(updateRequestEventUseCaseProvider);
      expect(usecaseInyected, isA<UpdateRequestEventUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
