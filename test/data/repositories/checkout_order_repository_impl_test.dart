import 'package:delivery_app/data/datasources/checkout_order_datasource_impl.dart';
import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../datasources_mocks.dart';
import '../../mocks.dart';

void main() {
  late final CheckoutOrderRepository repository;
  late final CheckoutOrderDatasourceMock datasource;
  late final ProviderContainer container;

  setUpAll(() {
    datasource = CheckoutOrderDatasourceMock();
    repository = CheckoutOrderRepositoryImpl(datasource: datasource);
    registerFallbackValue(Mocks.checkoutOrderMock);
    registerFallbackValue(Mocks.checkoutOrderModelMock);
    when(() => datasource.getAll()).thenAnswer((_) async => [Mocks.checkoutOrderModelMock]);
    when(() => datasource.getByUser(any())).thenAnswer((_) async => [Mocks.checkoutOrderModelMock]);
    when(() => datasource.getByEvent(any())).thenAnswer((_) async => [Mocks.checkoutOrderModelMock]);
    when(() => datasource.getById(any())).thenAnswer((_) async => Mocks.checkoutOrderModelMock);
    when(() => datasource.create(any())).thenAnswer((_) async =>'12324');
    when(() => datasource.update(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.updateCheckoutStatus(any(), any())).thenAnswer((_) async => {});
    when(() => datasource.delete(any())).thenAnswer((_) async => {});

    container = ProviderContainer(
      overrides: [
        checkoutOrderDatasourceProvider.overrideWithValue(
          datasource,
        ),
      ],
    );
  });

  test('validate get all correctly CheckoutOrder', () async {
      List<CheckoutOrder> list = await repository.getAll();
      expect(list.length, 1);
      verify(
        () => datasource.getAll(),
      ).called(1);
    });

  test('validate get byUser correctly CheckoutOrder', () async {
      List<CheckoutOrder> list = await repository.getByUser('1');
      expect(list.length, 1);
      verify(
        () => datasource.getByUser(any()),
      ).called(1);
    });

  test('validate get byEvent correctly CheckoutOrder', () async {
      List<CheckoutOrder> list = await repository.getByEvent('1');
      expect(list.length, 1);
      verify(
        () => datasource.getByEvent(any()),
      ).called(1);
    });

  test('validate updateCheckoutStatus correctly CheckoutOrder', () async {
      await repository.updateCheckoutStatus('1', {'status': ''});
      verify(
        () => datasource.updateCheckoutStatus(any(), any()),
      ).called(1);
    });

  test('validate get byId correctly CheckoutOrder', () async {
      CheckoutOrder? value = await repository.getById('1');
      expect(value, isNotNull);
      verify(
        () => datasource.getById(any()),
      ).called(1);
    });

  test('validate create correctly CheckoutOrder', () async {
      await repository.create(Mocks.checkoutOrderMock);
      verify(
        () => datasource.create(any()),
      ).called(1);
    });

    test('validate update correctly CheckoutOrder', () async {
      await repository.update('1', Mocks.checkoutOrderMock);
      verify(
        () => datasource.update(any(), any()),
      ).called(1);
    });

    test('validate delete correctly CheckoutOrder', () async {
      await repository.delete('1');
      verify(
        () => datasource.delete(any()),
      ).called(1);
    });

  test('Verify provider of repository', () async {
      final repositoryInyected = container.read(checkoutOrderRepositoryProvider);
      expect(repositoryInyected, isA<CheckoutOrderRepositoryImpl>());
      expect((repositoryInyected as CheckoutOrderRepositoryImpl).datasource, datasource);
    });

    tearDownAll(() {
      container.dispose();
    });
}