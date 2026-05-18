import 'package:delivery_app/data/datasources/product_datasource.dart';
import 'package:delivery_app/data/datasources/product_datasource_impl.dart';
import 'package:delivery_app/data/mappers/product_mapper.dart';
import 'package:delivery_app/data/models/product_model.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;
  final ProductMapper _mapper = ProductMapper();

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<Product?> getById(String id) async {
    try {
      ProductModel? model = await datasource.getById(id);
      return _mapper.toEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(Product product) async {
    try {
      ProductModel model = _mapper.toModel(product)!;
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, Product product) async {
    try {
      ProductModel model = _mapper.toModel(product)!;
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
      List<ProductModel> list = await datasource.getByCommerce(commerceId);
      return list.map((e) => _mapper.toEntity(e)!).toList();
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
