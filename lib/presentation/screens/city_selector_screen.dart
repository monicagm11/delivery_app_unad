import 'package:delivery_app/presentation/screens/city_selector_template.dart';
import 'package:delivery_app/presentation/screens/user_home_screen.dart';
import 'package:flutter/material.dart';

class CitySelectorScreen extends StatelessWidget {
  const CitySelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CitySelectorTemplate(onSaved: () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const UserHomeScreen()),
        );
    });
  }
  
}