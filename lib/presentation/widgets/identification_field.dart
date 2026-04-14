import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:flutter/material.dart';

class IdentificationFormField extends FormField<IdentificationData> {
  IdentificationFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    this.isEnabled = true
  }) : super(
          builder: (state) {
            return _IdentificationField(state: state, isEnabled: isEnabled,);
          },
        );
  final bool isEnabled;
}

class _IdentificationField extends StatefulWidget {
  final FormFieldState<IdentificationData> state;
  final bool isEnabled;
  const _IdentificationField({required  this.state, required this.isEnabled});

  @override
  State<_IdentificationField> createState() => _IdentificationFieldState();
}

class _IdentificationFieldState extends State<_IdentificationField> {
  String selectedCode = "CC";

  final codes = ["CC", "NIT", "CE"];
  late String code;
  final controller = TextEditingController();
  late final bool isEnabled;

  @override
  void initState() {
    super.initState();
    code = widget.state.value?.code ?? "CC";
    controller.text = widget.state.value?.number ?? "";
    isEnabled = widget.isEnabled;
  }

  void _update() {
    widget.state.didChange(
      IdentificationData(
        code: code,
        number: controller.text,
      ),
    );
    Form.of(context).validate();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        DropdownButton<String>(
            value: code,
            elevation: 0,
            items: codes.map((code) {
              return DropdownMenuItem(
                value: code,
                child: Text(code),
              );
            }).toList(),
            onChanged: isEnabled ? (value) {
              setState(() {
                  code = value!;
                });
              _update();
            } : null,
          ),
        Expanded(
              child: TextField(
                controller: controller,
                enabled: isEnabled,
                onChanged: (_) => _update(),
                decoration: InputDecoration(
                  errorText: widget.state.errorText,
                  label: Text('Identificación')
                ),
              ),
            ),
      ],
    );
  }
}