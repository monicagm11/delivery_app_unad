import 'package:delivery_app/domain/entities/cart_item.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/presentation/notifier/cart/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  bool addItem(Product product, String eventId, String eventName, String commerceId) {
    if (state.isEmpty || state.eventId == eventId) {
      final existing = state.items.indexWhere((i) => i.product.id == product.id);
      List<CartItem> updated;
      if (existing >= 0) {
        updated = [...state.items];
        updated[existing] = updated[existing].copyWith(
          quantity: updated[existing].quantity + 1,
        );
      } else {
        updated = [...state.items, CartItem(product: product, quantity: 1)];
      }
      state = state.copyWith(items: updated, eventId: eventId, eventName: eventName, commerce: commerceId);
      return true;
    }
    return false;
  }

  void removeItem(String productId) {
    final updated = state.items.where((i) => i.product.id != productId).toList();
    state = updated.isEmpty
        ? const CartState()
        : state.copyWith(items: updated);
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }
    final updated = state.items.map((i) {
      return i.product.id == productId ? i.copyWith(quantity: quantity) : i;
    }).toList();
    state = state.copyWith(items: updated);
  }

  void updateLocation(String? location) {
    state = state.copyWith(location: location);
  }

  void clear() => state = const CartState();
}

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier());
