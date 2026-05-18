import 'package:delivery_app/presentation/notifier/login/auth_notifier.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/screens/commerce_events_screen.dart';
import 'package:delivery_app/presentation/screens/delivery_orders_screen.dart';
import 'package:delivery_app/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _DeliveryNavItem { events, orders, settings }

class DeliveryHomeScreen extends ConsumerStatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  ConsumerState<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends ConsumerState<DeliveryHomeScreen> {
  _DeliveryNavItem _current = _DeliveryNavItem.orders;

  void _logout() {
    ref.read(sessionNotifierProvider.notifier).clear();
    ref.read(authNotifierProvider.notifier).resetState();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.delivery_dining, size: 24),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Row(
              children: [
                const Icon(Icons.person_outline, size: 18),
                const SizedBox(width: 4),
                Text(
                  session.userName ?? session.user?.email ?? '',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _DeliveryNavItem.values.indexOf(_current),
        onDestinationSelected: (i) =>
            setState(() => _current = _DeliveryNavItem.values[i]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event),
            label: 'Eventos',
          ),
          NavigationDestination(
            icon: Icon(Icons.delivery_dining_outlined),
            selectedIcon: Icon(Icons.delivery_dining),
            label: 'Pedidos',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_current) {
      case _DeliveryNavItem.events:
        return const CommerceEventsScreen();
      case _DeliveryNavItem.orders:
        return const DeliveryOrdersScreen();
      case _DeliveryNavItem.settings:
        return const SettingsScreen();
    }
  }
}
