import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/checkout_order_datasource.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutOrderDatasourceImpl
    extends BaseFirestoreDatasource<CheckoutOrderModel>
    implements CheckoutOrderDatasource {
  CheckoutOrderDatasourceImpl({required super.firestore})
      : super(collectionName: 'checkout_orders');

  @override
  Future<List<CheckoutOrderModel>> getAll() async =>
      await fetchAll(CheckoutOrderModel.fromMap) ?? [];

  @override
  Future<List<CheckoutOrderModel>> getByUser(String userId) async =>
      await fetchWhere(CheckoutOrderModel.fromMap, 'userId', userId) ?? [];

  @override
  Future<List<CheckoutOrderModel>> getByEvent(String eventId) async =>
      await fetchWhere(CheckoutOrderModel.fromMap, 'eventId', eventId) ?? [];

  @override
  Future<CheckoutOrderModel?> getById(String id) async =>
      await findById(id, CheckoutOrderModel.fromMap);

  @override
  Future<void> create(CheckoutOrderModel model) async {
    try {
      await add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, CheckoutOrderModel model) async {
    try {
      await updateDoc(id, model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}

final checkoutOrderDatasourceProvider =
    Provider<CheckoutOrderDatasource>((ref) {
  return CheckoutOrderDatasourceImpl(
      firestore: ref.read(firebaseFirestoreProvider));
});
