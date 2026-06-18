import 'package:delivery_app/presentation/notifier/city_selector/city_selector_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of city selector state created', () {
    CitySelectorState state = StateMocks.citySelectorStateMock;
    expect(state.isLoading, false);
    expect(state.errorMessage, isNull);
    expect(state.departmentOptions.length, 1);
  });

  test('Validate properties of city selector initial state', () {
    CitySelectorState state = CitySelectorState.initial();
    expect(state.isLoading, false);
    expect(state.errorMessage, isNull);
    expect(state.departmentOptions, isEmpty);
  });

  test('Validate properties of city selector state copied', () {
    CitySelectorState statePrevious = StateMocks.citySelectorStateMock;
    CitySelectorState state = statePrevious.copyWith(isLoading: true);
    expect(state.isLoading, true);
    expect(state.errorMessage, isNull);
    expect(state.departmentOptions.length, 1);
  });
}