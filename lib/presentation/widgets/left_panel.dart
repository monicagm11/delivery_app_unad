import 'package:delivery_app/presentation/utils/image_constants.dart';
import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  final bool hideText;
  final String imagePath;
  const LeftPanel(this.hideText, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(width: hideText ? 200 : double.infinity, ImageConstants.registerImage),
          if (!hideText) const SizedBox(height: 20),
          if (!hideText) Text(
            'EVENTDASH',
            textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        letterSpacing: 3,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF1565C0)),
          ),
          
        ],
      ),
    );
  }
}
