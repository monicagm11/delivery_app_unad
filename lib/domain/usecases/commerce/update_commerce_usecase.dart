import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/repositories/commerce_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateCommerceUseCase {
  final CommerceRepository repository;

  UpdateCommerceUseCase({required this.repository});

  Future<void> call(String id, Commerce model) async {
    try {
      await repository.update(id, model);
    } catch (e) {
      rethrow;
    }
  }
}

final updateCommerceUseCaseProvider = Provider<UpdateCommerceUseCase>((ref) {
  return UpdateCommerceUseCase(repository: ref.read(commerceRepositoryProvider));
});