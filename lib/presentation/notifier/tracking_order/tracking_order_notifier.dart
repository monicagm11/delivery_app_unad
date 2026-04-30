import 'dart:async';

import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/usecases/checkout/update_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/watch_document_usecase.dart';
import 'package:delivery_app/presentation/notifier/tracking_order/tracking_order_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackingOrderNotifier extends StateNotifier<TrackingOrderState> {
  TrackingOrderNotifier({required this.useCase, required this.updateCheckoutOrderUseCase})
      : super(TrackingOrderState.initial());

  final WatchDocumentUsecase<CheckoutOrder> useCase;
  StreamSubscription<CheckoutOrder?>? _subscription;
  final UpdateCheckoutOrderUseCase updateCheckoutOrderUseCase;

  void init(String orderId) {
    state = state.copyWith(orderId: orderId);
    _subscribe(useCase.where(orderId));
  }

  void _subscribe(Stream<CheckoutOrder?> stream) {
    _subscription?.cancel();
    state = state.copyWith(isLoading: true, errorMessage: null);
    _subscription = stream.listen(
      (item) => state = state.copyWith(item: item, isLoading: false),
      onError: (e) => state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ),
    );
  }

  Future<void> updateStatus(String status) async {
    CheckoutOrder orderModel = state.item!;
    final now = DateTime.now();
    orderModel.addTrackingStage(TrackingStage(name: status, date: now, completed: true));

    await updateCheckoutOrderUseCase.call(state.orderId, orderModel);
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final trackingOrderRealtimeProvider =
    StateNotifierProvider<TrackingOrderNotifier, TrackingOrderState>((ref) {
  final useCase = WatchDocumentUsecase<CheckoutOrder>(
    firestore: ref.read(firebaseFirestoreProvider),
    collectionName: 'checkout_orders',
    mapper: CheckoutOrderModel.fromMap,
  );

  return TrackingOrderNotifier(
      useCase: useCase,
      updateCheckoutOrderUseCase: ref.read(updateCheckoutOrderUseCaseProvider));
});