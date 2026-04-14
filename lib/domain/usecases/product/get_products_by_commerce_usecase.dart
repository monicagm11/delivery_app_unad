import 'package:delivery_app/data/repositories/product_repository_impl.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetProductsByCommerceUsecase {
  final ProductRepository repository;

  GetProductsByCommerceUsecase({required this.repository});

  Future<List<Product>> call(String commerceId) async {
    try {
      return await repository.getByCommerce(commerceId);
    } catch (e) {
      rethrow;
    }
  }
}

final getAllProductsUseCaseProvider = Provider<GetProductsByCommerceUsecase>((ref) {
  return GetProductsByCommerceUsecase(repository: ref.read(productRepositoryProvider));
});