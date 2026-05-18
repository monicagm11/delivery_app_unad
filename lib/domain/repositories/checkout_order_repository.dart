import 'package:delivery_app/domain/entities/checkout_order.dart';

abstract class CheckoutOrderRepository {
  Future<List<CheckoutOrder>> getAll();
  Future<List<CheckoutOrder>> getByUser(String userId);
  Future<List<CheckoutOrder>> getByEvent(String eventId);
  Future<CheckoutOrder?> getById(String id);
  Future<String> create(CheckoutOrder model);
  Future<void> update(String id, CheckoutOrder model);
  Future<void> delete(String id);
  Future<void> updateCheckoutStatus(String id, Map<String, dynamic> newFields);
}
