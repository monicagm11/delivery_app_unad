import 'package:delivery_app/data/datasources/local_storage_datasource.dart';
import 'package:delivery_app/data/datasources/local_storage_datasource_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late LocalStorageDatasource datasource;
  ProviderContainer? container;

  setUp(() {
    SharedPreferences.setMockInitialValues({
      'username': 'Monica',
    });

    datasource = LocalStorageDatasourceImpl();
  });

  test('Verify provider of localStorage datasource', () async {
    container = ProviderContainer(
    );
    final datasourceInyected = container!.read(localStorageDatasourceProvider);
    expect(datasourceInyected, isA<LocalStorageDatasourceImpl>());
  });

  test('return value by key correctly', () async {
    final result = await datasource.get('username');

    expect(result, 'Monica');
  });

  test('return null when key does not exist', () async {
    final result = await datasource.get('token');

    expect(result, isNull);
  });

  test('save value correctly', () async {
    await datasource.save('token', '123456');
    final result = await datasource.get('token');
    expect(result, '123456');
  });
}