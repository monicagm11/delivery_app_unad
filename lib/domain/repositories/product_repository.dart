import 'package:delivery_app/data/models/product_model.dart';
import 'package:delivery_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getByCommerce(String commerceId);
  Future<Product?> getById(String id);
  Future<void> create(ProductModel model);
  Future<void> update(String id, ProductModel model);
  Future<void> delete(String id);
}
