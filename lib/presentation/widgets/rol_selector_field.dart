import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/rol_data.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class RolSelectorFormField extends FormField<RolData> {
  RolSelectorFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    this.isEnabled = true,
    required this.roles,
    required this.commerceOptions
  }) : super(
          builder: (state) {
            return _RolSelectorField(
              state: state,
              isEnabled: isEnabled,
              roles: roles,
              commerceOptions: commerceOptions,
            );
          },
        );
  final bool isEnabled;
  final List<DropdownOption> roles;
  final List<DropdownOption> commerceOptions;
}

class _RolSelectorField extends StatefulWidget {
  final FormFieldState<RolData> state;
  final bool isEnabled;
  final List<DropdownOption> roles;
  final List<DropdownOption> commerceOptions;
  const _RolSelectorField(
      {required this.state,
      required this.isEnabled,
      required this.roles,
      required this.commerceOptions});

  @override
  State<_RolSelectorField> createState() => _RolSelectorFieldState();
}

class _RolSelectorFieldState extends State<_RolSelectorField> {
  late String? rolCode, commerceCode;
  final controller = TextEditingController();
  late final bool isEnabled;
  late List<DropdownOption> rolesOptions, commerceOptions;
  bool _showCommerce = false;

  @override
  void initState() {
    super.initState();
    commerceOptions = widget.commerceOptions;
    rolesOptions = widget.roles;

    rolCode = widget.state.value?.rol;
    commerceCode = widget.state.value?.commerce;

    if (commerceCode != null && commerceCode!.isNotEmpty || ( rolCode != null && rolCode!= Constants.adminRolCode)) {
      _showCommerce = true;
    }

    isEnabled = widget.isEnabled;
  }

  void _update() {
    widget.state.didChange(
      RolData(
        rol: rolCode ?? '',
        commerce: commerceCode
      ),
    );
    Form.of(context).validate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        DropdownButtonFormField<String>(
            value: rolCode,
            decoration: InputDecoration(labelText: 'Rol'),
            elevation: 0,
            isExpanded: true,
            items: rolesOptions.map((code) {
              return DropdownMenuItem(
                value: code.value,
                child: Text(code.label, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: isEnabled ? (value) {
              setState(() {
                rolCode = value;
                _showCommerce = rolCode != Constants.adminRolCode;
                if (rolCode == Constants.adminRolCode) commerceCode = null;
                });
              _update();
            } : null,
          ),
        if (_showCommerce) DropdownButtonFormField<String>(
            value: commerceCode,
            elevation: 0,
            decoration: InputDecoration(labelText: 'Comercio'),
            items: commerceOptions.map((code) {
              return DropdownMenuItem(
                value: code.value,
                child: Text(code.label),
              );
            }).toList(),
            onChanged: isEnabled ? (value) {
              setState(() {
                  commerceCode = value;
                });
              _update();
            } : null,
          ),
      ],
    );
  }
}