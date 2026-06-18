import 'package:delivery_app/presentation/notifier/events_available/events_available_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../state_mocks.dart';

void main() {
  test('Validate properties of eventsAvailable state created', () {
    EventsAvailableState state = StateMocks.eventsAvailableStateMock;
    expect(state.eventItems.length, 1);
    expect(state.isLoading, false);
    expect(state.filteredEventItems.length, 1);
    expect(state.errorMessage, isNull);
    expect(state.localEvents.length, 1);
    expect(state.department, 'ATLANTICO');
    expect(state.city, 'BARRANQUILLA');
    expect(state.currentStateSelected, 'INICIADO');
  });

  test('Validate properties of eventsAvailable initial state', () {
    EventsAvailableState state = EventsAvailableState.initial('INICIADO');
    expect(state.eventItems.length, 0);
    expect(state.isLoading, true);
    expect(state.filteredEventItems.length, 0);
    expect(state.errorMessage, isNull);
    expect(state.localEvents.length, 0);
    expect(state.department, '');
    expect(state.city, '');
    expect(state.currentStateSelected, 'INICIADO');
  });

  test('Validate properties of eventsAvailable state copied', () {
    EventsAvailableState statePrevious = StateMocks.eventsAvailableStateMock;
    EventsAvailableState state = statePrevious.copyWith(isLoading: true);
    expect(state.eventItems.length, 1);
    expect(state.isLoading, true);
    expect(state.filteredEventItems.length, 1);
    expect(state.errorMessage, isNull);
    expect(state.localEvents.length, 1);
    expect(state.department, 'ATLANTICO');
    expect(state.city, 'BARRANQUILLA');
    expect(state.currentStateSelected, 'INICIADO');
  });
}