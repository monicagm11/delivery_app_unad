import 'package:delivery_app/domain/entities/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);

  double get subtotal => product.totalPrice * quantity;
  double get subtotalIva => product.valueIva * quantity;
  double get percentageIva => product.percentageIva;
  double get subtotalBase  => product.priceBase * quantity;
}
