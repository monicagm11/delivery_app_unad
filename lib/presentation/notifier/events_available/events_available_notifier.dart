import 'package:delivery_app/domain/entities/event_item.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/usecases/event/get_event_by_city_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_global_event_by_city_usecase.dart';
import 'package:delivery_app/domain/usecases/local_storage/get_string_localstorage_usecase.dart';
import 'package:delivery_app/presentation/notifier/events_available/events_available_state.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsAvailableNotifier extends StateNotifier<EventsAvailableState> {
  final GetStringLocalstorageUsecase getStringLocalstorageUsecase;
  final GetGlobalEventByCityUsecase getGlobalEventByCityUsecase;
  final GetEventByCityUsecase getEventByCityUsecase;

  EventsAvailableNotifier(
      {required this.getStringLocalstorageUsecase,
      required this.getGlobalEventByCityUsecase,
      required this.getEventByCityUsecase})
      : super(EventsAvailableState.initial(Constants.startedStatus));

  Future<void> init(String? idGlobalEvent) async {
    try {
      String departmentSelected =
          await getStringLocalstorageUsecase(Constants.keyDepartment) ?? '';
      String citySelected =
          await getStringLocalstorageUsecase(Constants.keyCity) ?? '';
      List<GlobalEvent> globalEvents =
          await getGlobalEventByCityUsecase(citySelected, departmentSelected);

      List<LocalEvent> localEvents =
          await getEventByCityUsecase(citySelected, departmentSelected);

      List<EventItem> eventItems = [
        ...globalEvents.map(EventItem.fromGlobal),
        ...localEvents.map(EventItem.fromLocal),
      ];
      List<EventItem> filteredItems =
          filterList(state.currentStateSelected, eventItems);

      state = state.copyWith(
        idGlobalEvent: idGlobalEvent,
          city: citySelected,
          department: departmentSelected,
          isLoading: false,
          eventItems: eventItems,
          filteredEventItems: filteredItems);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadAll() async {
    try {
      String departmentSelected =
          await getStringLocalstorageUsecase(Constants.keyDepartment) ?? '';
      String citySelected =
          await getStringLocalstorageUsecase(Constants.keyCity) ?? '';
      List<GlobalEvent> globalEvents =
          await getGlobalEventByCityUsecase(citySelected, departmentSelected);

      List<LocalEvent> localEvents =
          await getEventByCityUsecase(citySelected, departmentSelected);

      List<EventItem> eventItems = [
        ...globalEvents.map(EventItem.fromGlobal),
        ...localEvents.map(EventItem.fromLocal),
      ];
      List<EventItem> filteredItems =
          filterList(state.currentStateSelected, eventItems);

      state = state.copyWith(
          city: citySelected,
          department: departmentSelected,
          isLoading: false,
          eventItems: eventItems,
          filteredEventItems: filteredItems);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  List<EventItem> filterList(String targetStatus, List<EventItem> allEvents) {
    String? idGlobalEvent = state.idGlobalEvent;
    return allEvents.where((e) {
      if (idGlobalEvent != null && idGlobalEvent.isNotEmpty) {
        return !e.isGlobal &&
            e.idGlobalEvent == idGlobalEvent &&
            e.status == targetStatus;
      }
      return e.status == targetStatus;
    }).toList();
  }

  void updateStateSelected(String stateSelected) {
    List<EventItem> currentItems = state.eventItems;
    List<EventItem> filtered = filterList(stateSelected, currentItems);
    state = state.copyWith(filteredEventItems: filtered, currentStateSelected: stateSelected);
  }
}

final eventsAvailableNotifierProvider =
    StateNotifierProvider<EventsAvailableNotifier, EventsAvailableState>((ref) {
  return EventsAvailableNotifier(
      getStringLocalstorageUsecase: ref.read(getStringUseCaseProvider),
      getEventByCityUsecase: ref.read(getEventByCityUseCaseProvider),
      getGlobalEventByCityUsecase:
          ref.read(getGlobalEventByCityUseCaseProvider));
});
