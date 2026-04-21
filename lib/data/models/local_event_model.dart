import 'package:delivery_app/domain/entities/local_event.dart';

class LocalEventModel extends LocalEvent {
  LocalEventModel({
    required super.id,
    required super.name,
    required super.description,
    required super.longitude,
    required super.latitude,
    required super.radious,
    required super.scheduleDate,
    required super.startDate,
    required super.endDate,
    required super.department,
    required super.city,
    required super.status,
    required super.productsIdList
  });

  factory LocalEventModel.fromMap(Map<String, dynamic> map) => LocalEventModel(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        description: map['description'] as String? ?? '',
        longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
        latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
        radious: (map['radious'] as num?)?.toDouble() ?? 0.0,
        scheduleDate: map['scheduleDate'] as String? ?? '',
        startDate: map['startDate'] as String? ?? '',
        endDate: map['endDate'] as String? ?? '',
        department: map['department'] as String? ?? '',
        city: map['city'] as String? ?? '',
        status: map['status'] as String? ?? '',
        productsIdList: List<String>.from(map['products'] as List? ?? []),
      );

  
}
