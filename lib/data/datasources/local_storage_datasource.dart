abstract class LocalStorageDatasource {
  Future<void> save(String key, String value);
  Future<String?> get(String key);
}