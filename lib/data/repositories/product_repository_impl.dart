import 'package:delivery_app/data/datasources/product_datasource.dart';
import 'package:delivery_app/data/datasources/product_datasource_impl.dart';
import 'package:delivery_app/data/models/product_model.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<Product?> getById(String id) async {
    try {
      return await datasource.getById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(ProductModel model) async {
    try {
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, ProductModel model) async {
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
  
  @override
  Future<List<Product>> getByCommerce(String commerceId) async {
    try {
      return await datasource.getByCommerce(commerceId);
    } catch (e) {
      rethrow;
    }
  }
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    datasource: ref.read(productDatasourceProvider),
  );
});
