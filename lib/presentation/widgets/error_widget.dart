import 'package:flutter/material.dart';

class ErrorIconWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorIconWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.do_not_disturb, size: 80),
        const SizedBox(height: 20),
        Text(
          errorMessage,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
