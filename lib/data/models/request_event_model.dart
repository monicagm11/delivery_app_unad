
class RequestEventModel{
  const RequestEventModel({
    required this.id,
    required this.commerceId,
    required this.commerceName,
    required this.status,
    required this.eventId,
    required this.creationDate,
    required this.productsIdList,
    required this.locationClientType
  });

  final String id;
  final String commerceId;
  final String commerceName;
  final String status;
  final String eventId;
  final String creationDate;
  final String locationClientType;
  final List<String> productsIdList;

  factory RequestEventModel.fromMap(Map<String, dynamic> map) => RequestEventModel(
        id: map['id'] as String? ?? '',
        commerceId: map['commerceId'] as String? ?? '',
        commerceName: map['commerceName'] as String? ?? '',
        status: map['status'] as String? ?? '',
        eventId: map['eventId'] as String? ?? '',
        creationDate: map['creationDate'] as String? ?? '',
        productsIdList: List<String>.from(map['products'] as List? ?? []), 
        locationClientType: map['locationClientType'] as String? ?? 'numberedChair',
        
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'commerceId': commerceId,
        'commerceName': commerceName,
        'status': status,
        'eventId': eventId,
        'creationDate': creationDate,
        'products': productsIdList,
        'locationClientType': locationClientType
      };
}
