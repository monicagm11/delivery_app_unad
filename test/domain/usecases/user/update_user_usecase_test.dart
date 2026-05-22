import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/usecases/user/update_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../repositories_mocks.dart';

void main() {
  late final UserRepositoryMock repository;
  late final UpdateUserUseCase useCase;
  late final ProviderContainer container;
  
  setUpAll(() {
    repository = UserRepositoryMock();
    useCase = UpdateUserUseCase(repository: repository);
    registerFallbackValue(Mocks.userMock);
    when(() => repository.update(any(), any())).thenAnswer((_) async => {});
    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
  });

  group('UpdateUserUseCase test', () {
    test('Invoke create method in usecase UpdateUserUseCase', () async {
    await useCase.call('ADFG567', Mocks.userMock);
    verify(() => repository.update(any(), any()),).called(1);
  });

  test('Verify provider of usecase', () async {
      final usecaseInyected =
          container.read(updateUserUseCaseProvider);
      expect(usecaseInyected, isA<UpdateUserUseCase>());
      expect(usecaseInyected.repository, repository);
    });

    tearDownAll(() {
      container.dispose();
    });

  });
}