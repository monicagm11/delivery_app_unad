import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAll();
  Future<List<Category>> getByCommerce(String commerceId);
  Future<Category?> getById(String id);
  Future<void> create(CategoryModel model);
  Future<void> update(String id, CategoryModel model);
  Future<void> delete(String id);
}
