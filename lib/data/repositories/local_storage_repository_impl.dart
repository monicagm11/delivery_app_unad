import 'package:delivery_app/data/datasources/local_storage_datasource.dart';
import 'package:delivery_app/data/datasources/local_storage_datasource_impl.dart';
import 'package:delivery_app/domain/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl({required this.datasource});
  @override
  Future<String?> get(String key) async {
    return datasource.get(key);
  }

  @override
  Future<void> save(String key, String value) async {
    datasource.save(key, value);
  }
}

final localStorageRepositoryProvider = Provider<LocalStorageRepository>((ref) {
  return LocalStorageRepositoryImpl(
    datasource: ref.read(localStorageDatasourceProvider)
  );
});