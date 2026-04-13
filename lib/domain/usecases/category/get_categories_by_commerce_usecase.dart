
import 'package:delivery_app/data/repositories/category_repository_impl.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCategoriesByCommerceUseCase {
  final CategoryRepository repository;
  GetCategoriesByCommerceUseCase({required this.repository});

  Future<List<Category>> call(String commerceId) async {
    try {
      return await repository.getByCommerce(commerceId);
    } catch (e) {
      rethrow;
    }
  }
}

final getCategoriesByCommerceUseCaseProvider = Provider<GetCategoriesByCommerceUseCase>((ref) {
  return GetCategoriesByCommerceUseCase(repository: ref.read(categoryRepositoryProvider));
});