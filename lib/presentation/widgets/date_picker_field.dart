import 'package:delivery_app/domain/entities/date_data.dart';
import 'package:delivery_app/domain/entities/form_field_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends FormField<DateData> {
  DatePickerField({
    super.key,
    required FormFieldConfig formFieldConfig,
    super.onSaved,
    bool isEnabled = true,
    bool showHourSelector = false,
    super.initialValue,
  }) : super(
          validator: (value) {
            if ((value == null || value.date.isEmpty || (showHourSelector && value.hour.isEmpty)) &&   
                formFieldConfig.isRequired) {
              return 'Campo requerido';
            }
            return null;
          },
          builder: (state) => _DatePickerFieldContent(
            state: state,
            formFieldConfig: formFieldConfig,
            isEnabled: isEnabled,
            showHourSelector: showHourSelector,
          ),
        );
}

class _DatePickerFieldContent extends StatefulWidget {
  final FormFieldState<DateData> state;
  final FormFieldConfig formFieldConfig;
  final bool isEnabled;
  final bool showHourSelector;

  const _DatePickerFieldContent({
    required this.state,
    required this.formFieldConfig,
    required this.isEnabled,
    required this.showHourSelector
  });

  @override
  State<_DatePickerFieldContent> createState() =>
      _DatePickerFieldContentState();
}

class _DatePickerFieldContentState extends State<_DatePickerFieldContent> {
  final _formatter = DateFormat('dd/MM/yyyy');
  late final TextEditingController _dateController, _hourController;
  late String dateSelected;
  late String hourSelected;
  late final bool showHourSelector;

  @override
  void initState() {
    super.initState();
    showHourSelector = widget.showHourSelector;
    dateSelected = widget.state.value?.date ?? '';
    hourSelected = widget.state.value?.hour ?? '';
    _dateController = TextEditingController(text: dateSelected);
    _hourController = TextEditingController(text: hourSelected);
  }

  void _update() {
    widget.state.didChange(
      DateData(
        date: dateSelected,
        hour: hourSelected
      ),
    );
    Form.of(context).validate();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    if (!widget.isEnabled) return;
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day + 1),
      firstDate: DateTime(now.year, now.month, now.day + 1),
      lastDate: DateTime(now.year + 1, now.month, now.day + 1),
    );
    if (picked == null) return;

    final formatted = _formatter.format(picked);
    _dateController.text = formatted;
    dateSelected = formatted;
    _update();
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked == null) return;

    final formatted =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    _hourController.text = formatted;
    hourSelected = formatted;
    _update();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _dateController,
            readOnly: true,
            enabled: widget.isEnabled,
            onTap: _pickDate,
            decoration: InputDecoration(
              labelText: widget.formFieldConfig.label,
              suffixIcon: const Icon(Icons.calendar_today),
              errorText: widget.state.errorText,
            ),
          ),
        ),
        if (showHourSelector) 
          SizedBox(
          width: 100,
          child: TextFormField(
              controller: _hourController,
              readOnly: true,
              enabled: widget.isEnabled,
              onTap: () {
                _pickTime();
              },
              decoration: InputDecoration(
                labelText: 'Hora',
                suffixIcon: const Icon(Icons.timer),
                errorText: widget.state.errorText,
              ),
            )
        ) ,
      ],
    );
  }
}
