import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/user/get_all_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final UserRepositoryMock repository;
  late final GetAllUsersUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = UserRepositoryMock();
    useCase = GetAllUsersUseCase(repository: repository);
    when(() => repository.getAll()).thenAnswer((_) async => [Mocks.userMock]);
    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('GetAllUsersUseCase test', () {
    test('Invoke create method in usecase GetAllUsersUseCase', () async {
      List<User> list = await useCase.call();
      expect(list.length, 1);
      verify(
        () => repository.getAll(),
      ).called(1);
    });
    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getAllUsersUseCaseProvider);
      expect(usecaseInyected, isA<GetAllUsersUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
