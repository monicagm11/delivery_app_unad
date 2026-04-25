import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/presentation/notifier/cart/cart_notifier.dart';
import 'package:delivery_app/presentation/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;
  final String eventId;
  final String eventName;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.eventId,
    required this.eventName,
  });

  Future<void> _handleAddToCart(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(cartNotifierProvider.notifier);
    final added = notifier.addItem(product, eventId, eventName);

    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} agregado al carrito'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Ver carrito',
            textColor: Colors.white,
            onPressed: () => _showCart(context, ref),
          ),
        ),
      );
    } else {
      // Evento diferente — mostrar advertencia
      final cart = ref.read(cartNotifierProvider);
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Carrito activo'),
          content: Text(
            'Ya tienes productos del evento "${cart.eventName}" en tu carrito.\n\n'
            '¿Deseas vaciar el carrito y agregar este producto del evento "$eventName"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                notifier.clear();
                notifier.addItem(product, eventId, eventName);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Carrito actualizado con ${product.name}'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Vaciar y agregar'),
            ),
          ],
        ),
      );
    }
  }

  void _showCart(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _CartSheet(ref: ref),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final inCart = cartState.items
        .where((i) => i.product.id == product.id)
        .map((i) => i.quantity)
        .firstOrNull ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => _showCart(context, ref),
              ),
              if (cartState.totalItems > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartState.totalItems}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            if (product.urlImage != null && product.urlImage!.isNotEmpty)
              Image.network(
                product.urlImage!,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imagePlaceholder(),
              )
            else
              _imagePlaceholder(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre y precio
                  
                  const SizedBox(height: 8),
                  if (product.description.isNotEmpty) ...[
                    Text('Descripción',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(product.description,
                        style: TextStyle(
                            color: Colors.grey.shade700, height: 1.5)),
                    const SizedBox(height: 24),
                  ],
                  const Divider(height: 24),
                  _PriceRow(
                      label: 'Precio base',
                      value: '\$${product.priceBase.toStringAsFixed(0)}'),
                  _PriceRow(
                      label: 'IVA (${product.percentageIva.toStringAsFixed(0)}%)',
                      value: '\$${product.valueIva.toStringAsFixed(0)}'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '\$${product.totalPrice.toStringAsFixed(0)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  // Evento
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.event, color: Colors.blue.shade700, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Disponible en: $eventName',
                            style: TextStyle(color: Colors.blue.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Botón agregar
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: inCart > 0
                        ? _QuantitySelector(
                            quantity: inCart,
                            onDecrement: () => ref
                                .read(cartNotifierProvider.notifier)
                                .updateQuantity(product.id, inCart - 1),
                            onIncrement: () => _handleAddToCart(context, ref),
                          )
                        : ElevatedButton.icon(
                            onPressed: () => _handleAddToCart(context, ref),
                            icon: const Icon(Icons.add_shopping_cart),
                            label: const Text('Agregar al carrito'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF1565C0),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
        width: double.infinity,
        height: 260,
        color: Colors.grey.shade100,
        child: Icon(Icons.image_outlined,
            size: 64, color: Colors.grey.shade400),
      );
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _QuantitySelector({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1565C0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.remove),
              color: const Color(0xFF1565C0),
              onPressed: onDecrement,
            ),
          ),
          Text(
            '$quantity',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.add),
              color: const Color(0xFF1565C0),
              onPressed: onIncrement,
            ),
          ),
        ],
      ),
    );
  }
}

class _CartSheet extends ConsumerWidget {
  final WidgetRef ref;
  const _CartSheet({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef _) {
    final cart = ref.watch(cartNotifierProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mi carrito',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                if (!cart.isEmpty)
                  TextButton(
                    onPressed: () {
                      ref.read(cartNotifierProvider.notifier).clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Vaciar',
                        style: TextStyle(color: Colors.red)),
                  ),
              ],
            ),
          ),
          if (cart.eventName != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.event, size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(cart.eventName!,
                      style: TextStyle(
                          color: Colors.grey.shade500, fontSize: 13)),
                ],
              ),
            ),
          const Divider(),
          Expanded(
            child: cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text('Tu carrito está vacío',
                            style:
                                TextStyle(color: Colors.grey.shade500)),
                      ],
                    ),
                  )
                : ListView.separated(
                    controller: controller,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final item = cart.items[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.product.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600)),
                        subtitle: Text(
                            '\$${item.product.totalPrice.toStringAsFixed(0)} c/u'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => ref
                                  .read(cartNotifierProvider.notifier)
                                  .updateQuantity(
                                      item.product.id, item.quantity - 1),
                            ),
                            Text('${item.quantity}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => ref
                                  .read(cartNotifierProvider.notifier)
                                  .updateQuantity(
                                      item.product.id, item.quantity + 1),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          if (!cart.isEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        '\$${cart.total.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF1565C0)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const CheckoutScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Finalizar compra',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
