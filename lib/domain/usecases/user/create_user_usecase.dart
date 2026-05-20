import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateUserUseCase {
  final UserRepository repository;
  CreateUserUseCase({required this.repository});

  Future<void> call(User model) async {
    try {
      await repository.create(model);
    } catch (e) {
      rethrow;
    }
  }
}

final createUserUseCaseProvider = Provider<CreateUserUseCase>((ref) {
  return CreateUserUseCase(repository: ref.read(userRepositoryProvider));
});