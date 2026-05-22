import 'package:delivery_app/data/datasources/user_datasource_impl.dart';
import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';
import '../../mocks.dart';

void main() {
  late final UserRepository repository;
  late final UserDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = UserDatasourceMock();
    repository = UserRepositoryImpl(datasource: datasource);
    registerFallbackValue(Mocks.userModelMock);
    when(() => datasource.getAll()).thenAnswer((_) async => [Mocks.userModelMock]);
    when(() => datasource.getByRolAndEventId(any(), any())).thenAnswer((_) async => [Mocks.userModelMock]);
    when(() => datasource.getById(any())).thenAnswer((_) async => Mocks.userModelMock);
    when(() => datasource.create(any())).thenAnswer((_) async => {});
    when(() => datasource.update(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.updateCurrentEventId(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.delete(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        userDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('validate get all correctly User', () async {
      List<User> list = await repository.getAll();
      expect(list.length, 1);
      verify(
        () => datasource.getAll(),
      ).called(1);
    });

  test('validate get byId correctly User', () async {
      User? value = await repository.getById('1');
      expect(value, isNotNull);
      verify(
        () => datasource.getById(any()),
      ).called(1);
    });

  test('validate get getByRolAndEventId correctly User', () async {
      List<User> value = await repository.getByRolAndEventId('ADMINISTRADOR', '1');
      expect(value.length, 1);
      verify(
        () => datasource.getByRolAndEventId(any(), any()),
      ).called(1);
    });

  test('validate create correctly User', () async {
      await repository.create(Mocks.userMock);
      verify(
        () => datasource.create(any()),
      ).called(1);
    });

    test('validate update correctly User', () async {
      await repository.update('1', Mocks.userMock);
      verify(
        () => datasource.update(any(), any()),
      ).called(1);
    });

    test('validate updateCurrentEventId correctly User', () async {
      await repository.updateCurrentEventId('1', 'event1');
      verify(
        () => datasource.updateCurrentEventId(any(), any()),
      ).called(1);
    });

    test('validate delete correctly User', () async {
      await repository.delete('1');
      verify(
        () => datasource.delete(any()),
      ).called(1);
    });

  test('Verify provider of repository', () async {
      final repositoryInyected = container.read(userRepositoryProvider);
      expect(repositoryInyected, isA<UserRepositoryImpl>());
      expect((repositoryInyected as UserRepositoryImpl).datasource, datasource);
    });

    tearDownAll(() {
      container.dispose();
    });
}