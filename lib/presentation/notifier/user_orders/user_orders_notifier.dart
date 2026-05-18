import 'dart:async';

import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/usecases/watch_collection_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserOrdersState {
  final bool isLoading;
  final List<CheckoutOrder> orders;
  final String? errorMessage;

  const UserOrdersState({
    required this.isLoading,
    required this.orders,
    this.errorMessage,
  });

  factory UserOrdersState.initial() =>
      const UserOrdersState(isLoading: false, orders: []);

  UserOrdersState copyWith({
    bool? isLoading,
    List<CheckoutOrder>? orders,
    String? errorMessage,
  }) =>
      UserOrdersState(
        isLoading: isLoading ?? this.isLoading,
        orders: orders ?? this.orders,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class UserOrdersNotifier extends StateNotifier<UserOrdersState> {
  UserOrdersNotifier({required this.useCase})
      : super(UserOrdersState.initial());

  final WatchCollectionUseCase<CheckoutOrder> useCase;
  StreamSubscription<List<CheckoutOrder>>? _subscription;

  void watchByField(String field, String value) {
    _subscription?.cancel();
    state = state.copyWith(isLoading: true, errorMessage: null);
    _subscription = useCase.where(field, value).listen(
      (orders) => state = state.copyWith(orders: orders, isLoading: false),
      onError: (e) => state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

WatchCollectionUseCase<CheckoutOrder> _buildUseCase(Ref ref) =>
    WatchCollectionUseCase<CheckoutOrder>(
      firestore: ref.read(firebaseFirestoreProvider),
      collectionName: 'checkout_orders',
      mapper: CheckoutOrder.fromMap,
    );

/// Órdenes donde userId == usuario actual.
final userOrdersProvider =
    StateNotifierProvider<UserOrdersNotifier, UserOrdersState>(
  (ref) => UserOrdersNotifier(useCase: _buildUseCase(ref)),
);

/// Órdenes donde idDeliveryAssigned == usuario actual (repartidor).
final deliveryOrdersProvider =
    StateNotifierProvider<UserOrdersNotifier, UserOrdersState>(
  (ref) => UserOrdersNotifier(useCase: _buildUseCase(ref)),
);
