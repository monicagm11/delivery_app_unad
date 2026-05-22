import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/create_request/get_request_events_by_commerce_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final RequestEventRepositoryMock repository;
  late final GetRequestEventsByCommerceUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = RequestEventRepositoryMock();
    useCase = GetRequestEventsByCommerceUseCase(repository: repository);
    when(() => repository.getByCommerce(any())).thenAnswer((_) async => [Mocks.requestEventMock]);
    container = ProviderContainer(
      overrides: [
        requestEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetRequestEventsByCommerceUseCase test', () {
    test('Invoke method in usecase GetRequestEventsByCommerceUseCase', () async {
      await useCase.call('1');
      verify(
        () => repository.getByCommerce(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getRequestEventsByCommerceUseCaseProvider);
      expect(usecaseInyected, isA<GetRequestEventsByCommerceUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
