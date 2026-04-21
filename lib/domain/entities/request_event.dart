class RequestEvent {
  final String id;
  final String commerceId;
  final String status;
  final String eventId;
  final String creationDate;
  final List<String> productsIdList;

  const RequestEvent({
    required this.id,
    required this.commerceId,
    required this.status,
    required this.eventId,
    required this.creationDate,
    required this.productsIdList
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'commerceId': commerceId,
        'status': status,
        'eventId': eventId,
        'creationDate': creationDate,
        'products': productsIdList
      };
}
