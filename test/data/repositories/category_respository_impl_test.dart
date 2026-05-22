import 'package:delivery_app/data/datasources/category_datasource_impl.dart';
import 'package:delivery_app/data/repositories/category_repository_impl.dart';
import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';
import '../../mocks.dart';

void main() {
  late final CategoryRepository repository;
  late final CategoryDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = CategoryDatasourceMock();
    repository = CategoryRepositoryImpl(datasource: datasource);
    registerFallbackValue(Mocks.categoryModelMock);
    when(() => datasource.getAll()).thenAnswer((_) async => [Mocks.categoryModelMock]);
    when(() => datasource.getByCommerce(any())).thenAnswer((_) async => [Mocks.categoryModelMock]);
    when(() => datasource.getById(any())).thenAnswer((_) async => Mocks.categoryModelMock);
    when(() => datasource.create(any())).thenAnswer((_) async => {});
    when(() => datasource.update(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.delete(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        categoryDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('Verify provider of repository', () async {
      final repositoryInyected = container.read(categoryRepositoryProvider);
      expect(repositoryInyected, isA<CategoryRepositoryImpl>());
      expect((repositoryInyected as CategoryRepositoryImpl).datasource, datasource);
    });

    test('validate get all correctly Category', () async {
      List<Category> list = await repository.getAll();
      expect(list.length, 1);
      verify(
        () => datasource.getAll(),
      ).called(1);
    });

    test('validate get byCommerce correctly Category', () async {
      List<Category> list = await repository.getByCommerce('1');
      expect(list.length, 1);
      verify(
        () => datasource.getByCommerce(any()),
      ).called(1);
    });

    test('validate create correctly Category', () async {
      await repository.create(Mocks.categoryMock);
      verify(
        () => datasource.create(any()),
      ).called(1);
    });

    test('validate update correctly Category', () async {
      await repository.update('1', Mocks.categoryMock);
      verify(
        () => datasource.update(any(), any()),
      ).called(1);
    });

    test('validate delete correctly Category', () async {
      await repository.delete('1');
      verify(
        () => datasource.delete(any()),
      ).called(1);
    });

    test('validate get byId correctly Category', () async {
      Category? value = await repository.getById('1');
      expect(value, isNotNull);
      verify(
        () => datasource.getById(any()),
      ).called(1);
    });

    tearDownAll(() {
      container.dispose();
    });
}