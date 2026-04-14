import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/product_datasource.dart';
import 'package:delivery_app/data/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDatasourceImpl extends BaseFirestoreDatasource<ProductModel>
    implements ProductDatasource {
  ProductDatasourceImpl({required super.firestore})
      : super(collectionName: 'products');

  @override
  Future<List<ProductModel>> getByCommerce(String commerceId) async =>
      await fetchWhere(ProductModel.fromMap, 'commerce', commerceId) ?? [];

  @override
  Future<ProductModel?> getById(String id) async => await findById(id, ProductModel.fromMap);

  @override
  Future<void> create(ProductModel model) async {
    try {
      await add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, ProductModel model) async {
    try {
      await firestore.collection(collectionName).doc(id).update(model.toMap());
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

final productDatasourceProvider = Provider<ProductDatasource>((ref) {
  return ProductDatasourceImpl(
      firestore: ref.read(firebaseFirestoreProvider));
});
