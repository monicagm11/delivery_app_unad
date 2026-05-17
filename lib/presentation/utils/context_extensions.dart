import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/presentation/widgets/logistics_selector_dialog.dart';
import 'package:flutter/material.dart';

extension DialogsExtensions on BuildContext {
  Future<String?> showTextFieldDialog(String label) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(label),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(labelText: label),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<User?> showLogisticsSelectorDialog({
    String title = 'Seleccionar logístico',
    required List<User> users
  }) async {

    if (!mounted) return null;
    return showDialog<User>(
      context: this,
      barrierDismissible: false,
      builder: (_) => LogisticsSelectorDialog(users: users, title: title),
    );
  }

  Future<bool?> showConfirmationDialog(String message) {    return showDialog<bool>(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
