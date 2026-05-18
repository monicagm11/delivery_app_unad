import 'package:delivery_app/data/repositories/category_repository_impl.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateCategoryUseCase {
  final CategoryRepository repository;
  UpdateCategoryUseCase({required this.repository});

  Future<void> call(String id, Category model) async {
    try {
      await repository.update(id, model);
    } catch (e) {
      rethrow;
    }
  }
}

final updateCategoryUseCaseProvider = Provider<UpdateCategoryUseCase>((ref) {
  return UpdateCategoryUseCase(repository: ref.read(categoryRepositoryProvider));
});

