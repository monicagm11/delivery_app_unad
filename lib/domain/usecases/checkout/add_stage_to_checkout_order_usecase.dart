import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/repositories/checkout_order_repository_impl.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddStageToCheckoutOrderUseCase {
  final CheckoutOrderRepository repository;
  AddStageToCheckoutOrderUseCase({required this.repository});

  Future<void> call(String orderId, TrackingStage stage) async {
    try {
      await repository.updateCheckoutStatus(orderId, {
        'stageList': FieldValue.arrayUnion([stage.toMap()]),
      });
    } catch (e) {
      rethrow;
    }
  }
}

final addStageToCheckoutOrderUseCaseProvider =
    Provider<AddStageToCheckoutOrderUseCase>((ref) =>
        AddStageToCheckoutOrderUseCase(
            repository: ref.read(checkoutOrderRepositoryProvider)));
