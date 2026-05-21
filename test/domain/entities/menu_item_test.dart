import 'package:delivery_app/domain/entities/menu_item.dart';
import 'package:delivery_app/presentation/screens/commerce_crud_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of MenuItem created correctly', () {
    MenuItem model = MenuItem(
      title: 'Comercios',
      icon: Icons.store_outlined,
      code: 'commerce',
      screen: CommerceCrudScreen(),
    );
    expect(model.title, 'Comercios');
    expect(model.code, 'commerce');
    expect(model.icon, Icons.store_outlined);
  });
}