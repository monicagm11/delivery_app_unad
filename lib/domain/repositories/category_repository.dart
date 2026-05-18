import 'package:delivery_app/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAll();
  Future<List<Category>> getByCommerce(String commerceId);
  Future<Category?> getById(String id);
  Future<void> create(Category model);
  Future<void> update(String id, Category model);
  Future<void> delete(String id);
}
