import 'package:delivery_app/data/datasources/local_event_datasource_impl.dart';
import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';
import '../../mocks.dart';

void main() {
  late final LocalEventRepository repository;
  late final LocalEventDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = LocalEventDatasourceMock();
    repository = LocalEventRepositoryImpl(datasource: datasource);
    registerFallbackValue(Mocks.localEventModelMock);
    when(() => datasource.getAll()).thenAnswer((_) async => [Mocks.localEventModelMock]);
    when(() => datasource.getActiveByCity(any(), any())).thenAnswer((_) async => [Mocks.localEventModelMock]);
    when(() => datasource.getByCommerce(any())).thenAnswer((_) async => [Mocks.localEventModelMock]);
    when(() => datasource.getById(any())).thenAnswer((_) async => Mocks.localEventModelMock);
    when(() => datasource.create(any())).thenAnswer((_) async => {});
    when(() => datasource.update(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.delete(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        localEventDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('validate get all correctly LocalEvent', () async {
      List<LocalEvent> list = await repository.getAll();
      expect(list.length, 1);
      verify(
        () => datasource.getAll(),
      ).called(1);
    });

  test('validate get byCommerce correctly LocalEvent', () async {
      List<LocalEvent> list = await repository.getByCommerce('1');
      expect(list.length, 1);
      verify(
        () => datasource.getByCommerce(any()),
      ).called(1);
    });

  test('validate get active byCity correctly LocalEvent', () async {
      List<LocalEvent> list = await repository.getActiveByCity('BARRANQUILLA', 'ATLANTICO');
      expect(list.length, 1);
      verify(
        () => datasource.getActiveByCity(any(), any()),
      ).called(1);
    });

  test('validate get byId correctly LocalEvent', () async {
      LocalEvent? value = await repository.getById('1');
      expect(value, isNotNull);
      verify(
        () => datasource.getById(any()),
      ).called(1);
    });

  test('validate create correctly LocalEvent', () async {
      await repository.create(Mocks.localEventMock);
      verify(
        () => datasource.create(any()),
      ).called(1);
    });

    test('validate update correctly LocalEvent', () async {
      await repository.update('1', Mocks.localEventMock);
      verify(
        () => datasource.update(any(), any()),
      ).called(1);
    });

    test('validate delete correctly LocalEvent', () async {
      await repository.delete('1');
      verify(
        () => datasource.delete(any()),
      ).called(1);
    });

  test('Verify provider of repository', () async {
      final repositoryInyected = container.read(localEventRepositoryProvider);
      expect(repositoryInyected, isA<LocalEventRepositoryImpl>());
      expect((repositoryInyected as LocalEventRepositoryImpl).datasource, datasource);
    });

    tearDownAll(() {
      container.dispose();
    });
}