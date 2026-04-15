import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetUserByIdUseCase {
  final UserRepository repository;
  GetUserByIdUseCase({required this.repository});

  Future<User?> call(String id) async {
    try {
      return await repository.getById(id);
    } catch (e) {
      rethrow;
    }
  }
}

final getUserByIdUseCaseProvider = Provider<GetUserByIdUseCase>((ref) {
  return GetUserByIdUseCase(repository: ref.read(userRepositoryProvider));
});