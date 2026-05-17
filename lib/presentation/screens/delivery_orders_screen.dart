import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/notifier/user_orders/user_orders_notifier.dart';
import 'package:delivery_app/presentation/widgets/orders_list_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryOrdersScreen extends ConsumerWidget {
  const DeliveryOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(sessionNotifierProvider).userId ?? '';

    return OrdersListTemplate(
      provider: deliveryOrdersProvider,
      filterField: 'idDeliveryAssigned',
      filterValue: userId,
      title: 'Pedidos asignados',
      isFinalUser: false,
    );
  }
}
