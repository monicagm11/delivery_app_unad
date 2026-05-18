import 'package:delivery_app/domain/usecases/update_password_usecase.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Opciones del panel lateral
enum _SettingsOption {
  profileDetail,
  changePassword,
  about,
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _SettingsOption _selected = _SettingsOption.profileDetail;

  static const _options = [
    _SettingsOption.profileDetail,
    _SettingsOption.changePassword,
    _SettingsOption.about,
  ];

  int get _selectedIndex => _options.indexOf(_selected);

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile();
    return isMobile ? _buildMobile() : _buildDesktop(context);
  }

  // ── Mobile: NavigationRail ───────────────────────────────────────
  Widget _buildMobile() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) =>
              setState(() => _selected = _options[i]),
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: Text('Perfil'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.lock_outline),
              selectedIcon: Icon(Icons.lock),
              label: Text('Contraseña'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.info_outline),
              selectedIcon: Icon(Icons.info),
              label: Text('Acerca de'),
            ),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(child: _buildContent()),
      ],
    );
  }

  // ── Desktop: panel lateral con ListView ─────────────────────────
  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 240,
          child: Material(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _SectionHeader(title: 'Perfil'),
                _NavTile(
                  icon: Icons.person_outline,
                  label: 'Detalle de perfil',
                  selected: _selected == _SettingsOption.profileDetail,
                  onTap: () => setState(
                      () => _selected = _SettingsOption.profileDetail),
                ),
                _NavTile(
                  icon: Icons.lock_outline,
                  label: 'Cambio de contraseña',
                  selected: _selected == _SettingsOption.changePassword,
                  onTap: () => setState(
                      () => _selected = _SettingsOption.changePassword),
                ),
                const Divider(indent: 16, endIndent: 16),
                _SectionHeader(title: 'Ayuda'),
                _NavTile(
                  icon: Icons.info_outline,
                  label: 'Acerca de la aplicación',
                  selected: _selected == _SettingsOption.about,
                  onTap: () =>
                      setState(() => _selected = _SettingsOption.about),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    switch (_selected) {
      case _SettingsOption.profileDetail:
        return const _ProfileDetailView();
      case _SettingsOption.changePassword:
        return const _ChangePasswordView();
      case _SettingsOption.about:
        return const _AboutView();
    }
  }
}

// ── Componentes del panel izquierdo ─────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      selected: selected,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      leading: Icon(icon,
          size: 20,
          color: selected
              ? Theme.of(context).colorScheme.primary
              : null),
      title: Text(label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            color: selected ? Theme.of(context).colorScheme.primary : null,
          )),
      onTap: onTap,
    );
  }
}

// ── Detalle de perfil ────────────────────────────────────────────────────────

class _ProfileDetailView extends ConsumerWidget {
  const _ProfileDetailView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionNotifierProvider);
    final user = session.user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detalle de perfil',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(Icons.person,
                size: 40, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 24),
          _InfoRow(label: 'Correo', value: user?.email ?? '-'),
          _InfoRow(label: 'Rol', value: session.rolConfig?.name ?? '-'),
          _InfoRow(label: 'Comercio', value: session.commerce?.name ?? '-'),
          _InfoRow(label: 'ID de usuario', value: user?.id ?? '-'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

// ── Cambio de contraseña ─────────────────────────────────────────────────────

class _ChangePasswordView extends ConsumerStatefulWidget {
  const _ChangePasswordView();

  @override
  ConsumerState<_ChangePasswordView> createState() =>
      _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<_ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await ref.read(updatePasswordUseCaseProvider).call(
            currentPassword: _currentCtrl.text,
            newPassword: _newCtrl.text,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Contraseña actualizada correctamente'),
              backgroundColor: Colors.green),
        );
        _formKey.currentState!.reset();
        _currentCtrl.clear();
        _newCtrl.clear();
        _confirmCtrl.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cambio de contraseña',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              _PasswordField(
                controller: _currentCtrl,
                label: 'Contraseña actual',
                obscure: _obscureCurrent,
                onToggle: () =>
                    setState(() => _obscureCurrent = !_obscureCurrent),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              _PasswordField(
                controller: _newCtrl,
                label: 'Nueva contraseña',
                obscure: _obscureNew,
                onToggle: () => setState(() => _obscureNew = !_obscureNew),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (v.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _PasswordField(
                controller: _confirmCtrl,
                label: 'Confirmar nueva contraseña',
                obscure: _obscureConfirm,
                onToggle: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                validator: (v) => v != _newCtrl.text
                    ? 'Las contraseñas no coinciden'
                    : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Actualizar contraseña'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;

  const _PasswordField({
    required this.controller,
    required this.label,
    required this.obscure,
    required this.onToggle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: onToggle,
        ),
      ),
      validator: validator,
    );
  }
}

// ── Acerca de ────────────────────────────────────────────────────────────────

class _AboutView extends StatelessWidget {
  const _AboutView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Acerca de la aplicación',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 24),
          const Icon(Icons.set_meal, size: 64, color: Color(0xFF1565C0)),
          const SizedBox(height: 16),
          Text('Delivery App',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Versión 1.0.0',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          const Text(
            'Plataforma de gestión de pedidos y eventos para comercios. '
            'Permite administrar productos, categorías, usuarios y eventos '
            'de forma rápida y sencilla.',
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),
          _AboutRow(label: 'Desarrollado con', value: 'Flutter + Firebase'),
          _AboutRow(label: 'Plataformas', value: 'Web · Android · iOS'),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final String label;
  final String value;
  const _AboutRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
              width: 160,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Text(value),
        ],
      ),
    );
  }
}
