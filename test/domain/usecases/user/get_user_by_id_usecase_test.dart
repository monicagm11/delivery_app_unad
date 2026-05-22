import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final UserRepositoryMock repository;
  late final GetUserByIdUseCase useCase;
  late final ProviderContainer container;

  setUpAll(() {
    repository = UserRepositoryMock();
    useCase = GetUserByIdUseCase(repository: repository);
    when(() => repository.getById(any())).thenAnswer((_) async => Mocks.userMock);
    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('Get User by id use case test', () {
    test('Invoke create method in usecase GetUserByIdUseCase', () async {
      User? user = await useCase.call('1');
      expect(user, isNotNull);
      verify(
        () => repository.getById(any()),
      ).called(1);
    });
    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(getUserByIdUseCaseProvider);
      expect(usecaseInyected, isA<GetUserByIdUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
