import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/repositories/commerce_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllCommercesUseCase {
  final CommerceRepository repository;

  GetAllCommercesUseCase({required this.repository});

  Future<List<Commerce>> call() async {
    try {
      return await repository.getAll();
    } catch (e) {
      rethrow;
    }
  }
}

final getAllCommercesUseCaseProvider = Provider<GetAllCommercesUseCase>((ref) {
  return GetAllCommercesUseCase(repository: ref.read(commerceRepositoryProvider));
});