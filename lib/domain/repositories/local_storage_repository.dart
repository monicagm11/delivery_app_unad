abstract class LocalStorageRepository {
  Future<void> save(String key, String value);
  Future<String?> get(String key);
}