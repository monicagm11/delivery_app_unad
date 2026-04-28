import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllCheckoutOrdersUseCase {
  final CheckoutOrderRepository repository;
  GetAllCheckoutOrdersUseCase({required this.repository});
  Future<List<CheckoutOrder>> call() async {
    try { return await repository.getAll(); } catch (e) { rethrow; }
  }
}

final getAllCheckoutOrdersUseCaseProvider =
    Provider<GetAllCheckoutOrdersUseCase>((ref) =>
        GetAllCheckoutOrdersUseCase(
            repository: ref.read(checkoutOrderRepositoryProvider)));

