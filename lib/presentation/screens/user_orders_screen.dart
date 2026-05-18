import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/notifier/user_orders/user_orders_notifier.dart';
import 'package:delivery_app/presentation/widgets/orders_list_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserOrdersScreen extends ConsumerWidget {
  const UserOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(sessionNotifierProvider).user?.id ?? '';

    return OrdersListTemplate(
      provider: userOrdersProvider,
      filterField: 'userId',
      filterValue: userId,
      title: 'Mis pedidos',
      isFinalUser: true,
    );
  }
}
