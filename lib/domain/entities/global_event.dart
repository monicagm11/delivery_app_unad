class GlobalEvent {
  final String id;
  final String name;
  final String description;
  final double longitude;
  final double latitude;
  final double radious;
  final String scheduleDate;
  final String startDate;
  final String endDate;
  final String department;
  final String city;
  final String status;

  GlobalEvent(
      {required this.id,
      required this.name,
      required this.description,
      required this.longitude,
      required this.latitude,
      required this.radious,
      required this.scheduleDate,
      required this.startDate,
      required this.endDate,
      required this.department,
      required this.city,
      required this.status});
      
Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'longitude': longitude,
        'latitude': latitude,
        'radious': radious,
        'scheduleDate': scheduleDate,
        'startDate': startDate,
        'endDate': endDate,
        'department': department,
        'city': city,
        'status': status,
      };

  factory GlobalEvent.fromMap(Map<String, dynamic> map) => GlobalEvent(
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
      );
  
}
