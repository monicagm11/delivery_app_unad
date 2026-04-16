import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final Widget screen;
  final String code;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.screen,
    required this.code
  });
}