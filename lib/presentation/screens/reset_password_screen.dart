import 'package:delivery_app/presentation/notifier/login/auth_state.dart';
import 'package:delivery_app/presentation/notifier/reset_password/reset_password_notifer.dart';
import 'package:delivery_app/presentation/notifier/reset_password/reset_password_state.dart';
import 'package:delivery_app/presentation/widgets/left_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(resetPasswordNotifierProvider.notifier).reset(
          _emailController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResetPasswordState>(resetPasswordNotifierProvider, (_, state) {
      if (state.status == AuthStatus.success) {
        Navigator.of(context).pop();
      }
      if (state.status == AuthStatus.error && state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
        ref.read(resetPasswordNotifierProvider.notifier).resetState();
      }
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return isWide ? _WideLayout(
            formKey: _formKey,
            emailController: _emailController,
            obscurePassword: _obscurePassword,
            onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
            onSubmit: _submit,
          ) : _NarrowLayout(
            formKey: _formKey,
            emailController: _emailController,
            obscurePassword: _obscurePassword,
            onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
            onSubmit: _submit,
          );
        },
      ),
    );
  }
}

class _ResetForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;

  const _ResetForm({
    required this.formKey,
    required this.emailController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final isLoading =
            ref.watch(resetPasswordNotifierProvider).status == AuthStatus.loading;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Cambio de contraseña',
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
                  const SizedBox(height: 20),
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
                          : const Text('Enviar Link',
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;

  const _WideLayout({
    required this.formKey,
    required this.emailController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 2, child: LeftPanel(false)),
        Expanded(
          flex: 3,
          child: _ResetForm(
            formKey: formKey,
            emailController: emailController,
            obscurePassword: obscurePassword,
            onTogglePassword: onTogglePassword,
            onSubmit: onSubmit,
          ),
        ),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;

  const _NarrowLayout({
    required this.formKey,
    required this.emailController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 200, child: LeftPanel(true)),
        Expanded(
          child: _ResetForm(
            formKey: formKey,
            emailController: emailController,
            obscurePassword: obscurePassword,
            onTogglePassword: onTogglePassword,
            onSubmit: onSubmit,
          ),
        ),
      ],
    );
  }
}
