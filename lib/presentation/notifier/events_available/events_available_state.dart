import 'package:delivery_app/domain/entities/event_item.dart';
import 'package:delivery_app/domain/entities/local_event.dart';

class EventsAvailableState {
  final List<EventItem> eventItems;
  final List<EventItem> filteredEventItems;
  final List<LocalEvent> localEvents;
  final String department;
  final String city;
  final bool isLoading;
  final String? errorMessage;
  final String currentStateSelected;
  final String? idGlobalEvent;

  EventsAvailableState(
      {required this.eventItems,
      required this.filteredEventItems,
      required this.department,
      required this.city,
      required this.isLoading,
      required this.currentStateSelected,
      required this.localEvents,
      this.idGlobalEvent,
      this.errorMessage});

  factory EventsAvailableState.initial(String currentStateSelected) => EventsAvailableState(
      department: '',
      city: '',
      eventItems: [],
      filteredEventItems: [],
      localEvents: [],
      isLoading: true,
      errorMessage: null,
      currentStateSelected: currentStateSelected,
      idGlobalEvent: null);

  EventsAvailableState copyWith(
          {List<EventItem>? eventItems,
          List<EventItem>? filteredEventItems,
          List<LocalEvent>? localEvents,
          String? department,
          String? city,
          bool? isLoading,
          String? errorMessage,
          String? currentStateSelected,
          String? idGlobalEvent}) =>
      EventsAvailableState(
          eventItems: eventItems ?? this.eventItems,
          department: department ?? this.department,
          city: city ?? this.city,
          isLoading: isLoading ?? this.isLoading,
          errorMessage: errorMessage ?? this.errorMessage,
          filteredEventItems: filteredEventItems ?? this.filteredEventItems,
          currentStateSelected: currentStateSelected ?? this.currentStateSelected,
          idGlobalEvent: idGlobalEvent ?? this.idGlobalEvent,
          localEvents: localEvents ?? this.localEvents);
}
