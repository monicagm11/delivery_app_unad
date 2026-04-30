import 'package:delivery_app/data/models/checkout_order_model.dart';

abstract class CheckoutOrderDatasource {
  Future<List<CheckoutOrderModel>> getAll();
  Future<List<CheckoutOrderModel>> getByUser(String userId);
  Future<List<CheckoutOrderModel>> getByEvent(String eventId);
  Future<CheckoutOrderModel?> getById(String id);
  Future<String> create(CheckoutOrderModel model);
  Future<void> update(String id, CheckoutOrderModel model);
  Future<void> delete(String id);
}
