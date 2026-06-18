import 'package:delivery_app/domain/entities/department.dart';

class CitySelectorState {
  List<Department> departmentOptions;
  final bool isLoading;
  final String? errorMessage;
  CitySelectorState({
    required this.departmentOptions,
    required this.isLoading,
    this.errorMessage,
  });

  factory CitySelectorState.initial() => CitySelectorState(
        isLoading: false,
        errorMessage: null,
        departmentOptions: [],
      );

  CitySelectorState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showForm,
    List<Department>? departmentOptions,
  }) =>
      CitySelectorState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        departmentOptions: departmentOptions ?? this.departmentOptions,
      );
}