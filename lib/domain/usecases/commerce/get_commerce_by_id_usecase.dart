import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/repositories/commerce_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class GetCommerceByIdUseCase {
  final CommerceRepository repository;

  GetCommerceByIdUseCase({required this.repository});

  Future<Commerce?> call(String id) async {
    try {
      return await repository.getById(id);
    } catch (e) {
      rethrow;
    }
  }
}

final getCommerceByIdUseCaseProvider = Provider<GetCommerceByIdUseCase>((ref) {
  return GetCommerceByIdUseCase(repository: ref.read(commerceRepositoryProvider));
});
