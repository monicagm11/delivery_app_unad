import 'package:delivery_app/data/datasources/category_datasource.dart';
import 'package:delivery_app/data/datasources/category_datasource_impl.dart';
import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource datasource;

  CategoryRepositoryImpl({required this.datasource});

  @override
  Future<List<Category>> getAll() async {
    try {
      return await datasource.getAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> getByCommerce(String commerceId) async {
    try {
      return await datasource.getByCommerce(commerceId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Category?> getById(String id) async {
    try {
      return await datasource.getById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(CategoryModel model) async {
    try {
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, CategoryModel model) async {
    try {
      await datasource.update(id, model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await datasource.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl(
    datasource: ref.read(categoryDatasourceProvider),
  );
});
