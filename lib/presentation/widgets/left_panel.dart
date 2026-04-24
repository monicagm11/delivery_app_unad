import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  final bool hideText;
  const LeftPanel(this.hideText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1565C0),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!hideText) Text(
            'BIENVENIDO A',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 24),
          const Icon(Icons.set_meal, size: 80, color: Colors.white),
          if (!hideText) const SizedBox(height: 20),
          if (!hideText) Text(
            'Delivery App',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (!hideText) const SizedBox(height: 16),
          if (!hideText) Text(
            'Obtén tus pedidos de forma\nrápida y sencilla',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
