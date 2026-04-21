import 'package:delivery_app/domain/entities/request_event.dart';

class RequestEventModel extends RequestEvent {
  const RequestEventModel({
    required super.id,
    required super.commerceId,
    required super.status,
    required super.eventId,
    required super.creationDate,
    required super.productsIdList
  });

  factory RequestEventModel.fromMap(Map<String, dynamic> map) => RequestEventModel(
        id: map['id'] as String? ?? '',
        commerceId: map['commerceId'] as String? ?? '',
        status: map['status'] as String? ?? '',
        eventId: map['eventId'] as String? ?? '',
        creationDate: map['creationDate'] as String? ?? '',
        productsIdList: List<String>.from(map['products'] as List? ?? [])
      );

  
}
