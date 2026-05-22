import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/global_event/get_global_event_by_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final GlobalEventRepositoryMock repository;
  late final GetGlobalEventByIdUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = GlobalEventRepositoryMock();
    useCase = GetGlobalEventByIdUseCase(repository: repository);

    when(() => repository.getById(any())).thenAnswer((_) async => Mocks.globalEventMock);
    container = ProviderContainer(
      overrides: [
        globalEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetGlobalEventByIdUseCase test', () {
    test('Invoke method in usecase GetGlobalEventByIdUseCase', () async {
      await useCase('123465');
      verify(
        () => repository.getById(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getGlobalEventByIdUseCaseProvider);
      expect(usecaseInyected, isA<GetGlobalEventByIdUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
