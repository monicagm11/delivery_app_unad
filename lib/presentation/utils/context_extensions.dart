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

  Future<bool?> showConfirmationDialog(String message) {
    return showDialog<bool>(
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
