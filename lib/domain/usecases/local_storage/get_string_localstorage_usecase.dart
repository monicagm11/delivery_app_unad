import 'package:delivery_app/data/repositories/local_storage_repository_impl.dart';
import 'package:delivery_app/domain/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetStringLocalstorageUsecase {
  final LocalStorageRepository repository;

  GetStringLocalstorageUsecase({required this.repository});

  Future<String?> call(String key) async {
    try {
      return await repository.get(key);
    } catch (e) {
      return null;
    }
  }
}

final getStringUseCaseProvider = Provider<GetStringLocalstorageUsecase>((ref) =>
    GetStringLocalstorageUsecase(repository: ref.read(localStorageRepositoryProvider)));