import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/usecases/user/create_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final UserRepositoryMock repository;
  late final CreateUserUseCase useCase;
  late final ProviderContainer container;
  
  setUpAll(() {
    repository = UserRepositoryMock();
    useCase = CreateUserUseCase(repository: repository);
    registerFallbackValue(Mocks.userMock);
    when(() => repository.create(any())).thenAnswer((_) async => {});
    container = ProviderContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(
            repository,
          ),
        ],
      );
  });

  group('CreateUserUseCase test', () {
    test('Invoke create method in usecase CreateUserUseCase', () async {
      await useCase.call(Mocks.userMock);
      verify(
        () => repository.create(any()),
      ).called(1);
    });

    test('Verify provider of usecase', () async {
      final usecaseInyected = container.read(createUserUseCaseProvider);
      expect(usecaseInyected, isA<CreateUserUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
