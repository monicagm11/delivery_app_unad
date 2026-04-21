import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:flutter/material.dart';

class EventRequestFormField extends FormField<GlobalEvent> {
  EventRequestFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    this.isEnabled = true,
    required this.options
  }) : super(
          builder: (state) {
            return _EventRequestForm(state: state, options: options, initialValue: initialValue, isEnabled: isEnabled,);
          },
        );
  final bool isEnabled;
  final List<GlobalEvent> options;
}

class _EventRequestForm extends StatefulWidget {
  final FormFieldState<GlobalEvent?> state;
  final GlobalEvent? initialValue;
  final List<GlobalEvent> options;
  final bool isEnabled;
  const _EventRequestForm({this.initialValue, required this.options, required this.state, required this.isEnabled});


  @override
  State<StatefulWidget> createState() => _EventRequestFormState();
  
}

class _EventRequestFormState extends State<_EventRequestForm> {
  GlobalEvent? currentValue;
  late final List<GlobalEvent> options;
  late final bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.isEnabled;
    options = widget.options;
    currentValue = widget.initialValue;
  }

  void _update() {
    widget.state.didChange(
      currentValue,
    );
    Form.of(context).validate();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<GlobalEvent>(
        value: currentValue,
        decoration: InputDecoration(labelText: 'Selecciona un evento'),
        items: options
            .map((opt) => DropdownMenuItem(
                  value: opt,
                  child: Text(opt.name),
                ))
            .toList(),
        onChanged: isEnabled ? (value) {
          setState(() {
            currentValue = value;
          });
          _update();
        } : null,
        validator: (value) {
          if (value == null) return 'Campo requerido';
          return null;
        },
        onSaved:(_) {},
      ),
      _TextViewField(label: 'Descripción', data: currentValue?.description,),
      _TextViewField(label: 'Departamento', data: currentValue?.department,),
      _TextViewField(label: 'Ciudad', data: currentValue?.description,),
      _TextViewField(label: 'Fecha Programada', data: currentValue?.scheduleDate,)
      ],
    );
  }
}

class _TextViewField extends StatelessWidget {
  final String label;
  final String? data;

  const _TextViewField({required this.label, this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(data ?? '-')
      ],
    );
  }
}
