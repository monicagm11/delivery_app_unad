import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/data/repositories/category_repository_impl.dart';
import 'package:delivery_app/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCategoryUseCase {
  final CategoryRepository repository;
  CreateCategoryUseCase({required this.repository});

  Future<void> call(CategoryModel model) async {
    try {
      await repository.create(model);
    } catch (e) {
      rethrow;
    }
  }
}

final createCategoryUseCaseProvider = Provider<CreateCategoryUseCase>((ref) {
  return CreateCategoryUseCase(repository: ref.read(categoryRepositoryProvider));
});