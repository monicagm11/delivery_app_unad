import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/category_datasource.dart';
import 'package:delivery_app/data/models/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDatasourceImpl extends BaseFirestoreDatasource<CategoryModel>
    implements CategoryDatasource {
  CategoryDatasourceImpl({required super.firestore})
      : super(collectionName: 'categories');

  @override
  Future<List<CategoryModel>> getAll() async =>
      await fetchAll(CategoryModel.fromMap) ?? [];

  @override
  Future<List<CategoryModel>> getByCommerce(String commerceId) async =>
      await fetchWhere(CategoryModel.fromMap, 'commerce', commerceId) ?? [];

  @override
  Future<CategoryModel?> getById(String id) async =>
      await findById(id, CategoryModel.fromMap);

  @override
  Future<void> create(CategoryModel model) async {
    try {
      final map = model.toMap();
      await add(map);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, CategoryModel model) async {
    try {
      final map = model.toMap();
      await updateDoc(id, map);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}

final categoryDatasourceProvider = Provider<CategoryDatasource>((ref) {
  return CategoryDatasourceImpl(firestore: ref.read(firebaseFirestoreProvider));
});
