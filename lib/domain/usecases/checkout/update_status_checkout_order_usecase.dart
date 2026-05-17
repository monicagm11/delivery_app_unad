import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateStatusCheckoutOrderUsecase {
  final CheckoutOrderRepository repository;
  UpdateStatusCheckoutOrderUsecase({required this.repository});
  Future<void> call(String id, Map<String, dynamic> map) async {
    try { await repository.updateCheckoutStatus(id, map); } catch (e) { rethrow; }
  }
}

final updateStatusCheckoutOrderUsecaseProvider =
    Provider<UpdateStatusCheckoutOrderUsecase>((ref) =>
        UpdateStatusCheckoutOrderUsecase(
            repository: ref.read(checkoutOrderRepositoryProvider)));