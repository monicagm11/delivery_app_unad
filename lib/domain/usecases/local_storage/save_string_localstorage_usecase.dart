import 'package:delivery_app/data/repositories/local_storage_repository_impl.dart';
import 'package:delivery_app/domain/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveStringLocalstorageUsecase {
  final LocalStorageRepository repository;

  SaveStringLocalstorageUsecase({required this.repository});

  Future<void> call(String key, String value) async {
    try {
      await repository.save(key, value);
    } catch (e) {
      rethrow;
    }
  }
}

final saveStringUseCaseProvider = Provider<SaveStringLocalstorageUsecase>((ref) =>
    SaveStringLocalstorageUsecase(repository: ref.read(localStorageRepositoryProvider)));