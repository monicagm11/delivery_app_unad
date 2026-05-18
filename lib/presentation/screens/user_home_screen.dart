import 'package:delivery_app/presentation/notifier/login/auth_notifier.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/screens/events_available_screen.dart';
import 'package:delivery_app/presentation/screens/settings_screen.dart';
import 'package:delivery_app/presentation/screens/user_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _NavItem { events, orders, settings }

class UserHomeScreen extends ConsumerStatefulWidget {
  const UserHomeScreen({super.key});

  @override
  ConsumerState<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends ConsumerState<UserHomeScreen> {
  _NavItem _current = _NavItem.events;

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
        title: Row(
          children: [
            const Icon(Icons.set_meal, size: 24),
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
        selectedIndex: _NavItem.values.indexOf(_current),
        onDestinationSelected: (i) =>
            setState(() => _current = _NavItem.values[i]),
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
      case _NavItem.events:
        return const EventsAvailableScreen();
      case _NavItem.settings:
        return const SettingsScreen();
      case _NavItem.orders:
        return UserOrdersScreen();
    }
  }
}
