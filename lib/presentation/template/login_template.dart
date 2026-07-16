import 'package:delivery_app/presentation/utils/image_constants.dart';
import 'package:delivery_app/presentation/widgets/left_panel.dart';
import 'package:flutter/material.dart';

class LoginTemplate extends StatelessWidget {

  final Widget content;

  const LoginTemplate({super.key, required this.content});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return isWide ? _WideLayout(
            content: content,
          ) : _NarrowLayout(
            content: content,
          );
        },
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  final Widget content;

  const _WideLayout({
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 2, child: LeftPanel(false, ImageConstants.waiterImage)),
        Expanded(
          flex: 3,
          child: content,
        ),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  final Widget content;

  const _NarrowLayout({
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 200, child: LeftPanel(true, ImageConstants.waiterImage)),
        Expanded(
          child: content
        ),
      ],
    );
  }
}
