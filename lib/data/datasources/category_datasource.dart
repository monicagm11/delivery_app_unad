import 'package:delivery_app/data/models/category_model.dart';

abstract class CategoryDatasource {
  Future<List<CategoryModel>> getAll();
  Future<List<CategoryModel>> getByCommerce(String commerceId);
  Future<CategoryModel?> getById(String id);
  Future<void> create(CategoryModel model);
  Future<void> update(String id, CategoryModel model);
  Future<void> delete(String id);
}
