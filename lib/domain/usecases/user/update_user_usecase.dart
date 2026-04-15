import 'package:delivery_app/data/models/user_model.dart';
import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateUserUseCase {
  final UserRepository repository;
  UpdateUserUseCase({required this.repository});

  Future<void> call(String id, UserModel model) async {
    try {
      await repository.update(id, model);
    } catch (e) {
      rethrow;
    }
  }
}

final updateUserUseCaseProvider = Provider<UpdateUserUseCase>((ref) {
  return UpdateUserUseCase(repository: ref.read(userRepositoryProvider));
});
