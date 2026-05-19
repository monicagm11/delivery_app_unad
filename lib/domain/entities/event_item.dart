import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/entities/local_event.dart';

class EventItem {
  final String id;
  final String name;
  final String description;
  final String scheduleDate;
  final String startDate;
  final String city;
  final String department;
  final String status;
  final bool isGlobal;
  final String? idGlobalEvent;
  final String? commerceId;

  const EventItem({
    required this.id,
    required this.name,
    required this.description,
    required this.scheduleDate,
    required this.startDate,
    required this.city,
    required this.department,
    required this.status,
    required this.isGlobal,
    this.idGlobalEvent,
    this.commerceId,
  });

  factory EventItem.fromGlobal(GlobalEvent e) => EventItem(
        id: e.id,
        name: e.name,
        description: e.description,
        scheduleDate: e.scheduleDate,
        startDate: e.startDate,
        city: e.city,
        department: e.department,
        status: e.status,
        isGlobal: true,
      );

  factory EventItem.fromLocal(LocalEvent e) => EventItem(
        id: e.id,
        name: e.name,
        description: e.description,
        scheduleDate: e.scheduleDate,
        startDate: e.startDate,
        city: e.city,
        department: e.department,
        status: e.status,
        isGlobal: false,
        idGlobalEvent: e.idGlobalEvent,
        commerceId: e.commerce,
      );
}