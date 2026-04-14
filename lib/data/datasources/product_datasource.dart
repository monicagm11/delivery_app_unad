import 'package:delivery_app/data/models/product_model.dart';

abstract class ProductDatasource {
  Future<List<ProductModel>> getByCommerce(String commerceId);
  Future<ProductModel?> getById(String id);
  Future<void> create(ProductModel model);
  Future<void> update(String id, ProductModel model);
  Future<void> delete(String id);
}
