import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCheckoutOrderByIdUseCase {
  final CheckoutOrderRepository repository;
  GetCheckoutOrderByIdUseCase({required this.repository});
  Future<CheckoutOrder?> call(String id) async {
    try { return await repository.getById(id); } catch (e) { rethrow; }
  }
}

final getCheckoutOrderByIdUseCaseProvider =
    Provider<GetCheckoutOrderByIdUseCase>((ref) =>
        GetCheckoutOrderByIdUseCase(
            repository: ref.read(checkoutOrderRepositoryProvider)));
