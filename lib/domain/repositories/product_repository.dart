
import 'package:delivery_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getByCommerce(String commerceId);
  Future<Product?> getById(String id);
  Future<void> create(Product model);
  Future<void> update(String id, Product model);
  Future<void> delete(String id);
}
