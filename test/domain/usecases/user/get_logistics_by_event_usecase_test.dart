import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/user/get_logistics_by_event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final UserRepositoryMock repository;
  late final GetLogisticsByEventUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = UserRepositoryMock();
    useCase = GetLogisticsByEventUseCase(repository: repository);
    when(() => repository.getByRolAndEventId(any(), any())).thenAnswer((_) async => [Mocks.userMock]);
    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetLogisticsByEventUseCase test', () {
    test('Invoke create method in usecase GetLogisticsByEventUseCase', () async {
      List<User> list = await useCase.call('1');
      expect(list.length, 1);
      verify(
        () => repository.getByRolAndEventId(any(), any()),
      ).called(1);
    });
    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getLogisticsByEventUseCaseProvider);
      expect(usecaseInyected, isA<GetLogisticsByEventUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
