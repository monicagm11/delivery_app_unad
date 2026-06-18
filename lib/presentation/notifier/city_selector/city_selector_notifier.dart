import 'package:delivery_app/domain/usecases/functions/get_departments_usecase.dart';
import 'package:delivery_app/presentation/notifier/city_selector/city_selector_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CitySelectorNotifier extends StateNotifier<CitySelectorState> {

  final GetDepartmentsUseCase getDepartmentsUseCase;

  CitySelectorNotifier(
      {
      required this.getDepartmentsUseCase,
      })
      : super(CitySelectorState.initial());

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final departments = await getDepartmentsUseCase();
      state = state.copyWith(departmentOptions: departments, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  
}

final citySelectorNotifierProvider =
    StateNotifierProvider<CitySelectorNotifier, CitySelectorState>((ref) {
  return CitySelectorNotifier(
      getDepartmentsUseCase: ref.read(getDepartmentsUseCaseProvider));
});
