import 'package:delivery_app/domain/entities/user.dart';
import 'package:flutter/material.dart';


class LogisticsSelectorDialog extends StatefulWidget {
  final List<User> users;
  final String title;

  const LogisticsSelectorDialog({
    super.key,
    required this.users,
    this.title = 'Seleccionar logístico',
  });

  @override
  State<LogisticsSelectorDialog> createState() =>
      _LogisticsSelectorDialogState();
}

class _LogisticsSelectorDialogState extends State<LogisticsSelectorDialog> {
  User? _selected;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: widget.users.isEmpty
          ? const SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  'No hay logísticos disponibles para este evento.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : DropdownButtonFormField<User>(
              value: _selected,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Logístico',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Selecciona un logístico'),
              items: widget.users
                  .map((u) => DropdownMenuItem<User>(
                        value: u,
                        child: Text(
                          u.fullname ?? u.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selected = value),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed:
              _selected == null ? null : () => Navigator.pop(context, _selected),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
