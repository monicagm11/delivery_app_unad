import 'package:delivery_app/data/models/product_model.dart';
import 'package:delivery_app/data/repositories/product_repository_impl.dart';
import 'package:delivery_app/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase({required this.repository});

  Future<void> call(String id, ProductModel model) async {
    try {
      await repository.update(id, model);
    } catch (e) {
      rethrow;
    }
  }
}

final updateProductUseCaseProvider = Provider<UpdateProductUseCase>((ref) {
  return UpdateProductUseCase(repository: ref.read(productRepositoryProvider));
});