import 'package:delivery_app/presentation/notifier/login/auth_notifier.dart';
import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/screens/city_selector_screen.dart';
import 'package:delivery_app/presentation/screens/delivery_home_screen.dart';
import 'package:delivery_app/presentation/screens/home_screen.dart';
import 'package:delivery_app/presentation/screens/reset_password_screen.dart';
import 'package:delivery_app/presentation/screens/user_home_screen.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/widgets/left_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authNotifierProvider.notifier).login(
          _emailController.text,
          _passwordController.text,
        );
  }

  Future<void> _onLoginWithGoogle() async {
    await ref.read(authNotifierProvider.notifier).loginWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (_, state) {
      if (state.status == AuthStatus.success) {
        ref.read(sessionNotifierProvider.notifier).setSession(state.user, state.commerce, state.rolConfig);
        String rolId = state.rolId!;
        if (rolId == Constants.userRolCode) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => state.hasCitySelected == true ? UserHomeScreen() : CitySelectorScreen()),
          );
        } else if (rolId == Constants.logisticRolCode) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => DeliveryHomeScreen()),
          );
        } 
        else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        }
      }
      if (state.status == AuthStatus.error && state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
        ref.read(authNotifierProvider.notifier).resetState();
      }
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return isWide ? _WideLayout(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            obscurePassword: _obscurePassword,
            onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
            onSubmit: _submit,
            onLoginWithGoogle: _onLoginWithGoogle,
          ) : _NarrowLayout(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            obscurePassword: _obscurePassword,
            onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
            onSubmit: _submit,
            onLoginWithGoogle: _onLoginWithGoogle
          );
        },
      ),
    );
  }
}


class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;
  final VoidCallback onLoginWithGoogle;

  const _LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
    required this.onLoginWithGoogle
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final isLoading =
            ref.watch(authNotifierProvider).status == AuthStatus.loading;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Iniciar sesión',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Campo requerido';
                      if (!v.contains('@')) return 'Correo inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: onTogglePassword,
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Campo requerido';
                      if (v.length < 6) return 'Mínimo 6 caracteres';
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const ResetPasswordScreen()),
                        );
                      },
                      child: const Text('Olvidé la contraseña'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('INGRESAR',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: isLoading ? null : onLoginWithGoogle,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          spacing: 12,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/images/google.png'),
                            const Text('Ingresar con Google',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


class _WideLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;
  final VoidCallback onLoginWithGoogle;

  const _WideLayout({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
    required this.onLoginWithGoogle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 2, child: LeftPanel(false)),
        Expanded(
          flex: 3,
          child: _LoginForm(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController,
            obscurePassword: obscurePassword,
            onTogglePassword: onTogglePassword,
            onSubmit: onSubmit,
            onLoginWithGoogle: onLoginWithGoogle,
          ),
        ),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;
  final VoidCallback onLoginWithGoogle;

  const _NarrowLayout({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
    required this.onLoginWithGoogle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 200, child: LeftPanel(true)),
        Expanded(
          child: _LoginForm(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController,
            obscurePassword: obscurePassword,
            onTogglePassword: onTogglePassword,
            onSubmit: onSubmit,
            onLoginWithGoogle: onLoginWithGoogle,
          ),
        ),
      ],
    );
  }
}
