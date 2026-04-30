import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCheckoutOrderUseCase {
  final CheckoutOrderRepository repository;
  CreateCheckoutOrderUseCase({required this.repository});
  Future<String> call(CheckoutOrderModel model) async {
    try { return await repository.create(model); } catch (e) { rethrow; }
  }
}

final createCheckoutOrderUseCaseProvider =
    Provider<CreateCheckoutOrderUseCase>((ref) =>
        CreateCheckoutOrderUseCase(
            repository: ref.read(checkoutOrderRepositoryProvider)));
