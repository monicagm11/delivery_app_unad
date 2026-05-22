import 'package:delivery_app/data/datasources/request_event_datasource_impl.dart';
import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:delivery_app/domain/repositories/request_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';
import '../../mocks.dart';

void main() {
  late final RequestEventRepository repository;
  late final RequestEventDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = RequestEventDatasourceMock();
    repository = RequestEventRepositoryImpl(datasource: datasource);
    registerFallbackValue(Mocks.requestEventModelMock);
    when(() => datasource.getAll()).thenAnswer((_) async => [Mocks.requestEventModelMock]);
    when(() => datasource.getByCommerce(any())).thenAnswer((_) async => [Mocks.requestEventModelMock]);
    when(() => datasource.getById(any())).thenAnswer((_) async => Mocks.requestEventModelMock);
    when(() => datasource.create(any())).thenAnswer((_) async => {});
    when(() => datasource.update(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.delete(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        requestEventDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('validate get all correctly RequestEvent', () async {
      List<RequestEvent> list = await repository.getAll();
      expect(list.length, 1);
      verify(
        () => datasource.getAll(),
      ).called(1);
    });

  test('validate get byCommerce correctly RequestEvent', () async {
      List<RequestEvent> value = await repository.getByCommerce('1');
      expect(value.length, 1);
      verify(
        () => datasource.getByCommerce(any()),
      ).called(1);
    });
  
  test('validate get byId correctly RequestEvent', () async {
      RequestEvent? value = await repository.getById('1');
      expect(value, isNotNull);
      verify(
        () => datasource.getById(any()),
      ).called(1);
    });

  test('validate create correctly RequestEvent', () async {
      await repository.create(Mocks.requestEventMock);
      verify(
        () => datasource.create(any()),
      ).called(1);
    });

    test('validate update correctly RequestEvent', () async {
      await repository.update('1', Mocks.requestEventMock);
      verify(
        () => datasource.update(any(), any()),
      ).called(1);
    });

    test('validate delete correctly RequestEvent', () async {
      await repository.delete('1');
      verify(
        () => datasource.delete(any()),
      ).called(1);
    });

  test('Verify provider of repository', () async {
      final repositoryInyected = container.read(requestEventRepositoryProvider);
      expect(repositoryInyected, isA<RequestEventRepositoryImpl>());
      expect((repositoryInyected as RequestEventRepositoryImpl).datasource, datasource);
    });

    tearDownAll(() {
      container.dispose();
    });
}