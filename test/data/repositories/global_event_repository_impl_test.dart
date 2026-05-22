import 'package:delivery_app/data/datasources/global_event_datasource_impl.dart';
import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';
import '../../mocks.dart';

void main() {
  late final GlobalEventRepository repository;
  late final GlobalEventDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = GlobalEventDatasourceMock();
    repository = GlobalEventRepositoryImpl(datasource: datasource);
    registerFallbackValue(Mocks.globalEventModelMock);
    when(() => datasource.getAll()).thenAnswer((_) async => [Mocks.globalEventModelMock]);
    when(() => datasource.getAllActive()).thenAnswer((_) async => [Mocks.globalEventModelMock]);
    when(() => datasource.getActiveByCity(any(), any())).thenAnswer((_) async => [Mocks.globalEventModelMock]);
    when(() => datasource.getById(any())).thenAnswer((_) async => Mocks.globalEventModelMock);
    when(() => datasource.create(any())).thenAnswer((_) async => {});
    when(() => datasource.update(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.delete(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        globalEventDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('validate get all correctly GlobalEvent', () async {
      List<GlobalEvent> list = await repository.getAll();
      expect(list.length, 1);
      verify(
        () => datasource.getAll(),
      ).called(1);
    });

  test('validate get all active correctly GlobalEvent', () async {
      List<GlobalEvent> list = await repository.getAllActive();
      expect(list.length, 1);
      verify(
        () => datasource.getAllActive(),
      ).called(1);
    });

  test('validate get active byCity correctly GlobalEvent', () async {
      List<GlobalEvent> list = await repository.getActiveByCity('BARRANQUILLA', 'ATLANTICO');
      expect(list.length, 1);
      verify(
        () => datasource.getActiveByCity(any(), any()),
      ).called(1);
    });

  test('validate get byId correctly GlobalEvent', () async {
      GlobalEvent? value = await repository.getById('1');
      expect(value, isNotNull);
      verify(
        () => datasource.getById(any()),
      ).called(1);
    });

  test('validate create correctly GlobalEvent', () async {
      await repository.create(Mocks.globalEventMock);
      verify(
        () => datasource.create(any()),
      ).called(1);
    });

    test('validate update correctly GlobalEvent', () async {
      await repository.update('1', Mocks.globalEventMock);
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
      final repositoryInyected = container.read(globalEventRepositoryProvider);
      expect(repositoryInyected, isA<GlobalEventRepositoryImpl>());
      expect((repositoryInyected as GlobalEventRepositoryImpl).datasource, datasource);
    });

    tearDownAll(() {
      container.dispose();
    });
}