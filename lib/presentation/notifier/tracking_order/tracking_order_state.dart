import 'package:delivery_app/domain/entities/checkout_order.dart';

class TrackingOrderState {
  TrackingOrderState({
      this.item, required this.isLoading, this.errorMessage, required this.orderId});
  final CheckoutOrder? item;
  final bool isLoading;
  final String? errorMessage;
  final String orderId;

  factory TrackingOrderState.initial() => TrackingOrderState(
        isLoading: false,
        errorMessage: null,
        item: null,
        orderId: ''
      );

  TrackingOrderState copyWith({
    bool? isLoading,
    String? errorMessage,
    CheckoutOrder? item,
    String? orderId
  }) =>
      TrackingOrderState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        item: item ?? this.item,
        orderId: orderId ?? this.orderId
      );
}
