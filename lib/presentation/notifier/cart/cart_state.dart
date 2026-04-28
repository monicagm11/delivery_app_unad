import 'package:delivery_app/domain/entities/cart_item.dart';

class CartState {
  final List<CartItem> items;
  final String? eventId;
  final String? eventName;
  final String? commerce;

  const CartState({
    this.items = const [],
    this.eventId,
    this.eventName,
    this.commerce
  });

  bool get isEmpty => items.isEmpty;
  int get totalItems => items.fold(0, (sum, i) => sum + i.quantity);
  double get total => items.fold(0, (sum, i) => sum + i.subtotal);

  CartState copyWith({
    List<CartItem>? items,
    String? eventId,
    String? eventName,
    String? commerce
  }) =>
      CartState(
        items: items ?? this.items,
        eventId: eventId ?? this.eventId,
        eventName: eventName ?? this.eventName,
        commerce: commerce ?? this.commerce
      );
}
