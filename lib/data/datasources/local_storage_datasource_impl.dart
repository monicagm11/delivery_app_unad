import 'package:delivery_app/data/datasources/local_storage_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDatasourceImpl extends LocalStorageDatasource {
  @override
  Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}

final localStorageDatasourceProvider = Provider<LocalStorageDatasource>((ref) {
  return LocalStorageDatasourceImpl();
});