import 'package:delivery_app/data/datasources/checkout_order_datasource.dart';
import 'package:delivery_app/data/datasources/checkout_order_datasource_impl.dart';
import 'package:delivery_app/data/mappers/checkout_order_mapper.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutOrderRepositoryImpl implements CheckoutOrderRepository {
  final CheckoutOrderDatasource datasource;
  CheckoutOrderRepositoryImpl({required this.datasource});

  @override
  Future<List<CheckoutOrder>> getAll() async {
    try { return await datasource.getAll(); } catch (e) { rethrow; }
  }

  @override
  Future<List<CheckoutOrder>> getByUser(String userId) async {
    try { return await datasource.getByUser(userId); } catch (e) { rethrow; }
  }

  @override
  Future<List<CheckoutOrder>> getByEvent(String eventId) async {
    try { return await datasource.getByEvent(eventId); } catch (e) { rethrow; }
  }

  @override
  Future<CheckoutOrder?> getById(String id) async {
    try { return await datasource.getById(id); } catch (e) { rethrow; }
  }

  @override
  Future<String> create(CheckoutOrderModel model) async {
    try { return await datasource.create(model); } catch (e) { rethrow; }
  }

  @override
  Future<void> update(String id, CheckoutOrder model) async {
    try {
      CheckoutOrderModel checkoutOrderModel =
          CheckoutOrderMapper.toModel(model);
      await datasource.update(id, checkoutOrderModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try { await datasource.delete(id); } catch (e) { rethrow; }
  }
}

final checkoutOrderRepositoryProvider =
    Provider<CheckoutOrderRepository>((ref) {
  return CheckoutOrderRepositoryImpl(
      datasource: ref.read(checkoutOrderDatasourceProvider));
});
