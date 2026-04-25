class LocalEvent {
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
  final List<String> productsIdList;
  final String? idGlobalEvent;
  final String commerce;

  LocalEvent({
    required this.id,
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
    required this.status,
    required this.productsIdList,
    required this.commerce,
    this.idGlobalEvent,
  });

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
        'products': productsIdList,
        'idGlobalEvent': idGlobalEvent,
        'commerce': commerce,
      };
}
