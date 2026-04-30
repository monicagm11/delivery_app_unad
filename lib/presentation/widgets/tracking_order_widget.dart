import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

/// Representa una etapa en la línea de tiempo del pedido.
class TrackingOrderWidget extends StatelessWidget {
  final String status;
  final List<CheckoutItem> items;
  final List<TrackingStage> stages;

  const TrackingOrderWidget({
    super.key,
    required this.status,
    required this.items,
    required this.stages,
  });

  Color _chipColor(String status) {
    switch (status) {
      case Constants.orderCreatedStatus:
        return Colors.orange;
      case Constants.orderConfirmedStatus:
        return Colors.yellow;
      case Constants.orderAssignededStatus:
        return Colors.lightBlueAccent;
      case Constants.orderSendedStatus:
        return Colors.blue;
      case Constants.orderDoneStatus:
        return Colors.green;
      case Constants.orderCanceledStatus:
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Text(
            'Pedido en curso',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Chip de estado
          Chip(
            label: Text(
              status,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            backgroundColor: _chipColor(status),
          ),
          const SizedBox(height: 20),

          // Lista de productos
          Text('Productos', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.count}x ${item.nameProduct}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      '\$${item.priceTotal.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),

          // Línea de tiempo
          Text('Estado del pedido', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          _TrackingTimeline(stages: stages),
        ],
      ),
    );
  }
}

class _TrackingTimeline extends StatelessWidget {
  final List<TrackingStage> stages;

  const _TrackingTimeline({required this.stages});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(stages.length, (index) {
        final stage = stages[index];
        final isLast = index == stages.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Indicador + línea vertical
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    _StageIndicator(completed: stage.completed),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: stage.completed ? Colors.green : Colors.grey.shade300,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Nombre y fecha
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: stage.completed ? Colors.green.shade700 : Colors.grey.shade600,
                        ),
                      ),
                      if (stage.date != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          _formatDate(stage.date!),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$min';
  }
}

class _StageIndicator extends StatelessWidget {
  final bool completed;

  const _StageIndicator({required this.completed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: completed ? Colors.green : Colors.grey.shade300,
        border: Border.all(
          color: completed ? Colors.green : Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: completed
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }
}
