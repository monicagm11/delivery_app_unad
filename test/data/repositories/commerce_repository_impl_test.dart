import 'package:delivery_app/data/datasources/commerce_datasource_impl.dart';
import 'package:delivery_app/data/repositories/commerce_repository_impl.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/repositories/commerce_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';
import '../../mocks.dart';

void main() {
  late final CommerceRepository repository;
  late final CommerceDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = CommerceDatasourceMock();
    repository = CommerceRepositoryImpl(datasource: datasource);
    registerFallbackValue(Mocks.commerceModelMock);
    when(() => datasource.getAll()).thenAnswer((_) async => [Mocks.commerceModelMock]);
    when(() => datasource.getById(any())).thenAnswer((_) async => Mocks.commerceModelMock);
    when(() => datasource.create(any())).thenAnswer((_) async => {});
    when(() => datasource.update(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.delete(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        commerceDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('validate get all correctly Commerce', () async {
      List<Commerce> list = await repository.getAll();
      expect(list.length, 1);
      verify(
        () => datasource.getAll(),
      ).called(1);
    });

  test('validate get byId correctly Commerce', () async {
      Commerce? value = await repository.getById('1');
      expect(value, isNotNull);
      verify(
        () => datasource.getById(any()),
      ).called(1);
    });

  test('validate create correctly Commerce', () async {
      await repository.create(Mocks.commerceMock);
      verify(
        () => datasource.create(any()),
      ).called(1);
    });

    test('validate update correctly Commerce', () async {
      await repository.update('1', Mocks.commerceMock);
      verify(
        () => datasource.update(any(), any()),
      ).called(1);
    });

    test('validate delete correctly Commerce', () async {
      await repository.delete('1');
      verify(
        () => datasource.delete(any()),
      ).called(1);
    });

  test('Verify provider of repository', () async {
      final repositoryInyected = container.read(commerceRepositoryProvider);
      expect(repositoryInyected, isA<CommerceRepositoryImpl>());
      expect((repositoryInyected as CommerceRepositoryImpl).datasource, datasource);
    });

    tearDownAll(() {
      container.dispose();
    });
}