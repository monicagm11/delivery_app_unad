import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllUsersUseCase {
  final UserRepository repository;
  GetAllUsersUseCase({required this.repository});

  Future<List<User>> call() async {
    try {
      return await repository.getAll();
    } catch (e) {
      rethrow;
    }
  }
}

final getAllUsersUseCaseProvider = Provider<GetAllUsersUseCase>((ref) {
  return GetAllUsersUseCase(repository: ref.read(userRepositoryProvider));
});