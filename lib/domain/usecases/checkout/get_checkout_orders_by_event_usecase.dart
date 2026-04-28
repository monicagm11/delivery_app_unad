import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCheckoutOrdersByEventUseCase {
  final CheckoutOrderRepository repository;
  GetCheckoutOrdersByEventUseCase({required this.repository});
  Future<List<CheckoutOrder>> call(String eventId) async {
    try { return await repository.getByEvent(eventId); } catch (e) { rethrow; }
  }
}

final getCheckoutOrdersByEventUseCaseProvider =
    Provider<GetCheckoutOrdersByEventUseCase>((ref) =>
        GetCheckoutOrdersByEventUseCase(
            repository: ref.read(checkoutOrderRepositoryProvider)));
