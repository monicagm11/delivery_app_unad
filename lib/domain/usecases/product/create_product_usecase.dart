import 'package:delivery_app/data/models/product_model.dart';
import 'package:delivery_app/data/repositories/product_repository_impl.dart';
import 'package:delivery_app/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateProductUseCase {
  final ProductRepository repository;

  CreateProductUseCase({required this.repository});

  Future<void> call(ProductModel model) async {
    try {
      await repository.create(model);
    } catch (e) {
      rethrow;
    }
  }
}

final createProductUseCaseProvider = Provider<CreateProductUseCase>((ref) {
  return CreateProductUseCase(repository: ref.read(productRepositoryProvider));
});