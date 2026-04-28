import 'package:delivery_app/domain/entities/cart_item.dart';
import 'package:delivery_app/domain/entities/commerce.dart';

class CheckoutState {
  final List<CartItem> items;
  final String? eventId;
  final String? eventName;
  final bool isLoading;
  final String? errorMessage;
  final Commerce? commerce;
  final bool isCheckoutCompleted;

  const CheckoutState({
    this.items = const [],
    this.eventId,
    this.eventName,
    required this.isLoading,
    this.errorMessage,
    this.commerce,
    this.isCheckoutCompleted = false
  });

  bool get isEmpty => items.isEmpty;
  int get totalItems => items.fold(0, (sum, i) => sum + i.quantity);
  double get total => items.fold(0, (sum, i) => sum + i.subtotal);

  factory CheckoutState.initial () => CheckoutState(isLoading: true);

  CheckoutState copyWith({
    List<CartItem>? items,
    String? eventId,
    String? eventName,
    bool? isLoading,
    String? errorMessage,
    Commerce? commerce,
    bool? isCheckoutCompleted
  }) =>
      CheckoutState(
        items: items ?? this.items,
        eventId: eventId ?? this.eventId,
        eventName: eventName ?? this.eventName,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        commerce: commerce ?? this.commerce,
        isCheckoutCompleted: isCheckoutCompleted ?? this.isCheckoutCompleted
      );
}
