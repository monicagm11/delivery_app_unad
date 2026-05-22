import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/usecases/global_event/get_global_event_by_city_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final GlobalEventRepositoryMock repository;
  late final GetGlobalEventByCityUsecase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = GlobalEventRepositoryMock();
    useCase = GetGlobalEventByCityUsecase(repository: repository);

    when(() => repository.getActiveByCity(any(), any())).thenAnswer((_) async => [Mocks.globalEventMock]);
    container = ProviderContainer(
      overrides: [
        globalEventRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetGlobalEventByCityUsecase test', () {
    test('Invoke method in usecase GetGlobalEventByCityUsecase', () async {
      await useCase('BARRANQUILLA', 'ATLANTICO');
      verify(
        () => repository.getActiveByCity(any(), any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getGlobalEventByCityUseCaseProvider);
      expect(usecaseInyected, isA<GetGlobalEventByCityUsecase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
