import 'package:delivery_app/data/datasources/category_datasource.dart';
import 'package:delivery_app/data/datasources/category_datasource_impl.dart';
import 'package:delivery_app/data/mappers/category_mapper.dart';
import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource datasource;
  final CategoryMapper mapper = CategoryMapper();

  CategoryRepositoryImpl({required this.datasource});

  @override
  Future<List<Category>> getAll() async {
    try {
      List<CategoryModel> list = await datasource.getAll();
      return list.map((e)=> mapper.toEntity(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> getByCommerce(String commerceId) async {
    try {
      List<CategoryModel> list = await datasource.getByCommerce(commerceId);
      return list.map((e)=> mapper.toEntity(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Category?> getById(String id) async {
    try {
      CategoryModel? category = await datasource.getById(id);
      return category != null ? mapper.toEntity(category) : null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(Category category) async {
    try {
      CategoryModel model = mapper.toModel(category);
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, Category category) async {
    try {
      CategoryModel model = mapper.toModel(category);
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
