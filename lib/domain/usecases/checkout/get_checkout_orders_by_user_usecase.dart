
import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCheckoutOrdersByUserUseCase {
  final CheckoutOrderRepository repository;
  GetCheckoutOrdersByUserUseCase({required this.repository});
  Future<List<CheckoutOrder>> call(String userId) async {
    try { return await repository.getByUser(userId); } catch (e) { rethrow; }
  }
}

final getCheckoutOrdersByUserUseCaseProvider =
    Provider<GetCheckoutOrdersByUserUseCase>((ref) =>
        GetCheckoutOrdersByUserUseCase(
            repository: ref.read(checkoutOrderRepositoryProvider)));
