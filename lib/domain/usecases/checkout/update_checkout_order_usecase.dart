
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateCheckoutOrderUseCase {
  final CheckoutOrderRepository repository;
  UpdateCheckoutOrderUseCase({required this.repository});
  Future<void> call(String id, CheckoutOrderModel model) async {
    try { await repository.update(id, model); } catch (e) { rethrow; }
  }
}

final updateCheckoutOrderUseCaseProvider =
    Provider<UpdateCheckoutOrderUseCase>((ref) =>
        UpdateCheckoutOrderUseCase(
            repository: ref.read(checkoutOrderRepositoryProvider)));
