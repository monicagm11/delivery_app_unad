import 'dart:convert';

import 'package:delivery_app/domain/entities/department.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetDepartmentsUseCase {
  Future<List<Department>> call() async {
    final raw = await rootBundle.loadString(
      'assets/json/departamentos_municipios_colombia.json',
    );
    final List<dynamic> json = jsonDecode(raw);
    return json
        .map((e) => Department(
              name: e['name'] as String,
              cities: List<String>.from(e['cities'] as List),
            ))
        .toList();
  }
}

final getDepartmentsUseCaseProvider = Provider<GetDepartmentsUseCase>(
  (_) => GetDepartmentsUseCase(),
);
