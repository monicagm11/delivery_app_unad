import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/presentation/notifier/user_orders/user_orders_notifier.dart';
import 'package:delivery_app/presentation/screens/tracking_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersListTemplate extends ConsumerStatefulWidget {
  final StateNotifierProvider<UserOrdersNotifier, UserOrdersState> provider;
  final String filterField;
  final String filterValue;
  final String title;
  final bool isFinalUser;

  const OrdersListTemplate({
    super.key,
    required this.provider,
    required this.filterField,
    required this.filterValue,
    required this.title,
    required this.isFinalUser,
  });

  @override
  ConsumerState<OrdersListTemplate> createState() => _OrdersListTemplateState();
}

class _OrdersListTemplateState extends ConsumerState<OrdersListTemplate> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(widget.provider.notifier)
          .watchByField(widget.filterField, widget.filterValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(UserOrdersState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
            const SizedBox(height: 12),
            Text(
              state.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    if (state.orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              'No hay pedidos disponibles',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) => _OrderCard(
        order: state.orders[i],
        isFinalUser: widget.isFinalUser,
      ),
    );
  }
}

// ── Card de orden ────────────────────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  final CheckoutOrder order;
  final bool isFinalUser;

  const _OrderCard({required this.order, required this.isFinalUser});

  String get _currentStatus =>
      order.stageList.isNotEmpty ? order.stageList.last.name : 'Sin estado';

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pendiente':
        return Colors.orange;
      case 'en camino':
        return Colors.blue;
      case 'entregado':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _currentStatus;

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: order.id != null
            ? () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrackingOrderScreen(
                      orderId: order.id!,
                      isFinalUser: isFinalUser,
                    ),
                  ),
                )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado: id + chip estado
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Pedido #${order.id ?? '—'}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Chip(
                    label: Text(
                      status,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: _statusColor(status),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Productos
              ...order.checkoutItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.count}x ${item.nameProduct}',
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 13),
                      ),
                      Text(
                        '\$${item.priceTotal.toStringAsFixed(0)}',
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(height: 16),

              // Total + flecha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${order.total.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey.shade400),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
