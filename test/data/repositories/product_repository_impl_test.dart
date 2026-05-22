import 'package:delivery_app/data/datasources/product_datasource_impl.dart';
import 'package:delivery_app/data/repositories/product_repository_impl.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';
import '../../mocks.dart';

void main() {
  late final ProductRepository repository;
  late final ProductDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = ProductDatasourceMock();
    repository = ProductRepositoryImpl(datasource: datasource);
    registerFallbackValue(Mocks.productModelMock);
    when(() => datasource.getByCommerce(any())).thenAnswer((_) async => [Mocks.productModelMock]);
    when(() => datasource.getById(any())).thenAnswer((_) async => Mocks.productModelMock);
    when(() => datasource.create(any())).thenAnswer((_) async => {});
    when(() => datasource.update(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.delete(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        productDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('validate get byCommerce correctly Product', () async {
      List<Product> value = await repository.getByCommerce('1');
      expect(value.length, 1);
      verify(
        () => datasource.getByCommerce(any()),
      ).called(1);
    });

  test('validate get byId correctly Product', () async {
      Product? value = await repository.getById('1');
      expect(value, isNotNull);
      verify(
        () => datasource.getById(any()),
      ).called(1);
    });

  test('validate create correctly Product', () async {
      await repository.create(Mocks.productMock);
      verify(
        () => datasource.create(any()),
      ).called(1);
    });

    test('validate update correctly Product', () async {
      await repository.update('1', Mocks.productMock);
      verify(
        () => datasource.update(any(), any()),
      ).called(1);
    });

    test('validate delete correctly Product', () async {
      await repository.delete('1');
      verify(
        () => datasource.delete(any()),
      ).called(1);
    });

  test('Verify provider of repository', () async {
      final repositoryInyected = container.read(productRepositoryProvider);
      expect(repositoryInyected, isA<ProductRepositoryImpl>());
      expect((repositoryInyected as ProductRepositoryImpl).datasource, datasource);
    });

    tearDownAll(() {
      container.dispose();
    });
}