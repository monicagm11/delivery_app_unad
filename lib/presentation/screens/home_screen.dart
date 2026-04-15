import 'package:delivery_app/presentation/notifier/login/auth_notifier.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/screens/category_crud_screen.dart';
import 'package:delivery_app/presentation/screens/commerce_crud_screen.dart';
import 'package:delivery_app/presentation/screens/product_crud_screen.dart';
import 'package:delivery_app/presentation/screens/user_crud_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Definición de items del menú
class _MenuItem {
  final String title;
  final IconData icon;
  final Widget screen;

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.screen,
  });
}

final _menuItems = [
  _MenuItem(
    title: 'Comercios',
    icon: Icons.store_outlined,
    screen: const CommerceCrudScreen(),
  ),
  _MenuItem(
    title: 'Categorías',
    icon: Icons.category_outlined,
    screen: const CategoryCrudScreen(),
  ),
  _MenuItem(
    title: 'Productos',
    icon: Icons.inventory_2_outlined,
    screen: const ProductCrudScreen(),
  ),
  _MenuItem(
    title: 'Usuarios',
    icon: Icons.people_outline,
    screen: const UserCrudScreen(),
  ),
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionNotifierProvider);
    final isWide = MediaQuery.of(context).size.width > 800;
    final selectedItem = _menuItems[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem.title),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                const Icon(Icons.person_outline, size: 18),
                const SizedBox(width: 6),
                Text(session.email ?? '', style: const TextStyle(fontSize: 13)),
                IconButton(
                  tooltip: 'Cerrar sesión',
                  icon: const Icon(Icons.logout),
                  onPressed: _logout,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: isWide ? null : _Drawer(
        selectedIndex: _selectedIndex,
        onSelect: (i) {
          setState(() => _selectedIndex = i);
          Navigator.of(context).pop();
        },
        onLogout: _logout,
      ),
      body: isWide
          ? Row(
              children: [
                _SideNav(
                  selectedIndex: _selectedIndex,
                  onSelect: (i) => setState(() => _selectedIndex = i),
                  onLogout: _logout,
                ),
                Expanded(child: selectedItem.screen),
              ],
            )
          : selectedItem.screen,
    );
  }

  void _logout() {
    ref.read(sessionNotifierProvider.notifier).clear();
    ref.read(authNotifierProvider.notifier).resetState();
    // Navigator.of(context).pushReplacementNamed('/login');
  }
}

class _SideNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;

  const _SideNav({
    required this.selectedIndex,
    required this.onSelect,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: const Color(0xFF0D47A1),
      child: Column(
        children: [
          const _DrawerHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (_, i) => _NavItem(
                item: _menuItems[i],
                selected: selectedIndex == i,
                onTap: () => onSelect(i),
              ),
            ),
          ),
          const Divider(color: Colors.white24),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white70),
            title: const Text('Cerrar sesión',
                style: TextStyle(color: Colors.white70)),
            onTap: onLogout,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;

  const _Drawer({
    required this.selectedIndex,
    required this.onSelect,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0D47A1),
      child: Column(
        children: [
          const _DrawerHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (_, i) => _NavItem(
                item: _menuItems[i],
                selected: selectedIndex == i,
                onTap: () => onSelect(i),
              ),
            ),
          ),
          const Divider(color: Colors.white24),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white70),
            title: const Text('Cerrar sesión',
                style: TextStyle(color: Colors.white70)),
            onTap: onLogout,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ── Componentes compartidos ──────────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
      color: const Color(0xFF1565C0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.set_meal, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            'Delivery App',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final _MenuItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: Colors.white12,
      leading: Icon(item.icon, color: selected ? Colors.white : Colors.white60),
      title: Text(
        item.title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.white60,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }
}
