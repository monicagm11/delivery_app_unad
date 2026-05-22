import 'package:delivery_app/data/datasources/local_storage_datasource_impl.dart';
import 'package:delivery_app/data/repositories/local_storage_repository_impl.dart';
import 'package:delivery_app/domain/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';

void main() {
  late final LocalStorageRepository repository;
  late final LocalStorageDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = LocalStorageDatasourceMock();
    repository = LocalStorageRepositoryImpl(datasource: datasource);
    when(() => datasource.get(any())).thenAnswer((_) async => 'value');
    when(() => datasource.save(any(), any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        localStorageDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('validate save correctly LocalStorage', () async {
      await repository.save('key', 'value');
      verify(
        () => datasource.save(any(), any()),
      ).called(1);
    });

  test('validate get correctly LocalStorage', () async {
      final value = await repository.get('key');
      expect(value, 'value');
      verify(
        () => datasource.get(any()),
      ).called(1);
    });

  test('Verify provider of repository', () async {
      final repositoryInyected = container.read(localStorageRepositoryProvider);
      expect(repositoryInyected, isA<LocalStorageRepositoryImpl>());
      expect((repositoryInyected as LocalStorageRepositoryImpl).datasource, datasource);
    });

    tearDownAll(() {
      container.dispose();
    });
}