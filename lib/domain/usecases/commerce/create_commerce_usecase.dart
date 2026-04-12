import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/repositories/commerce_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCommerceUseCase {
  final CommerceRepository repository;

  CreateCommerceUseCase({required this.repository});

  Future<void> call(CommerceModel model) async {
    try {
      await repository.create(model);
    } catch (e) {
      rethrow;
    }
  }
}

final createCommerceUseCaseProvider = Provider<CreateCommerceUseCase>((ref) {
  return CreateCommerceUseCase(repository: ref.read(commerceRepositoryProvider));
});