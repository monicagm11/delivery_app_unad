import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:flutter/material.dart';

class CitySelectorFormField extends FormField<CityData> {
  CitySelectorFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    this.isEnabled = true,
    required this.departments
  }) : super(
          builder: (state) {
            return _CitySelectorField(state: state, isEnabled: isEnabled, departments: departments,);
          },
        );
  final bool isEnabled;
  final List<Department> departments;
}

class _CitySelectorField extends StatefulWidget {
  final FormFieldState<CityData> state;
  final bool isEnabled;
  final List<Department> departments;
  const _CitySelectorField({required  this.state, required this.isEnabled, required this.departments});

  @override
  State<_CitySelectorField> createState() => _CitySelectorFieldState();
}

class _CitySelectorFieldState extends State<_CitySelectorField> {
  late String? departmentCode, cityCode;
  final controller = TextEditingController();
  late final bool isEnabled;
  late final List<Department> departments;
  late List<String> departmentOptions, cityOptions;
  Department? departmentSelected;

  @override
  void initState() {
    super.initState();
    departments = widget.departments;
    departmentOptions = departments.map((e) => e.name).toList();
    cityOptions = [];
    departmentCode = widget.state.value?.department;
    if (departmentCode  != null && departmentCode!.isNotEmpty) {
      departmentSelected = departments.firstWhere((e) => e.name == departmentCode, orElse: () => Department(name: '', cities: []),);
    }
    cityCode = widget.state.value?.city;

    if (cityCode != null && cityCode!.isNotEmpty && departmentSelected != null) {
      cityOptions = departmentSelected!.cities;
    }

    isEnabled = widget.isEnabled;
  }

  void _update() {
    widget.state.didChange(
      CityData(
        department: departmentCode ?? '',
        city: cityCode ?? ''
      ),
    );
    Form.of(context).validate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        DropdownButtonFormField<Department>(
            value: departmentSelected,
            decoration: InputDecoration(labelText: 'Departamento'),
            elevation: 0,
            isExpanded: true,
            items: departments.map((code) {
              return DropdownMenuItem(
                value: code,
                child: Text(code.name, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: isEnabled ? (value) {
              setState(() {
                departmentSelected = value;
                  departmentCode = value?.name;
                  cityOptions = value?.cities ?? [];
                  cityCode = null;
                });
              _update();
            } : null,
          ),
        DropdownButtonFormField<String>(
            value: cityCode,
            elevation: 0,
            decoration: InputDecoration(labelText: 'Ciudad'),
            items: cityOptions.map((code) {
              return DropdownMenuItem(
                value: code,
                child: Text(code),
              );
            }).toList(),
            onChanged: isEnabled ? (value) {
              setState(() {
                  cityCode = value;
                });
              _update();
            } : null,
          ),
      ],
    );
  }
}