import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';

class CheckoutOrder {
  final String? id;
  final String userId;
  final String userName;
  final String eventId;
  final String? urlImage;
  final String? change;
  final String? comments;
  final String commerce;
  final PaymentMethod paymentMethod;
  final List<CheckoutItem> checkoutItems;
  final List<TrackingStage> stageList;
  final double total;
  final String location;
  final String? idDeliveryAssigned;

  CheckoutOrder(
      {required this.userId,
      required this.eventId,
      required this.userName,
      this.urlImage,
      this.change,
      required this.commerce,
      required this.comments,
      required this.paymentMethod,
      required this.checkoutItems,
      required this.total,
      required this.stageList,
      required this.id,
      required this.location,
      this.idDeliveryAssigned});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'urlImage': urlImage,
      'change': change,
      'comments': comments,
      'commerce': commerce,
      'paymentMethod': paymentMethod.name,
      'checkoutItems': checkoutItems.map((e) => e.toMap()).toList(),
      'stageList': stageList.map((e) => e.toMap()).toList(),
      'total': total,
      'location': location,
      'idDeliveryAssigned': idDeliveryAssigned,
      'userName': userName
    };
  }

  CheckoutOrder copyWith(
      {String? userId,
      String? userName,
      String? eventId,
      String? urlImage,
      String? change,
      String? comments,
      String? commerce,
      String? id,
      PaymentMethod? paymentMethod,
      List<CheckoutItem>? checkoutItems,
      List<TrackingStage>? stageList,
      String? location,
      String? idDeliveryAssigned,
      double? total}) {
    return CheckoutOrder(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        eventId: eventId ?? this.eventId,
        urlImage: urlImage ?? this.urlImage,
        change: change ?? this.change,
        comments: comments ?? this.comments,
        commerce: commerce ?? this.commerce,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        checkoutItems: checkoutItems ?? this.checkoutItems,
        total: total ?? this.total,
        stageList: stageList ?? this.stageList,
        location: location ?? this.location,
        idDeliveryAssigned: idDeliveryAssigned ?? this.idDeliveryAssigned,
        userName: userName ?? this.userName);
  }

  void addTrackingStage(TrackingStage trackingStage) {
    stageList.add(trackingStage);
  }

  factory CheckoutOrder.fromMap(Map<String, dynamic> map) =>
      CheckoutOrder(
        id: map['id'] as String? ?? '',
        userId: map['userId'] as String? ?? '',
        eventId: map['eventId'] as String? ?? '',
        urlImage: map['urlImage'] as String?,
        change: map['change'] as String?,
        comments: map['comments'] as String? ?? '',
        commerce: map['commerce'] as String? ?? '',
        total: (map['total'] as num?)?.toDouble() ?? 0.0,
        idDeliveryAssigned: map['idDeliveryAssigned'] as String?,
        paymentMethod: map['paymentMethod'],
        checkoutItems: (map['checkoutItems'] as List<dynamic>? ?? [])
            .map((e) => CheckoutItem.fromMap(e as Map<String, dynamic>))
            .toList(),
        stageList: (map['stageList'] as List<dynamic>? ?? [])
            .map((e) => TrackingStage.fromMap(e as Map<String, dynamic>))
            .toList(),
        location: map['location'] as String? ?? '',
        userName: map['userName'] as String? ?? ''
      );
}

class TrackingStage {
  final String name;
  final DateTime? date;
  final bool completed;

  const TrackingStage({
    required this.name,
    this.date,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'completed': completed,
    };
  }

  factory TrackingStage.fromMap(Map<String, dynamic> map) {
    return TrackingStage(
        name: map['name'], 
        date: (map['date'] as Timestamp?)?.toDate(),
        completed: map['completed']);
  }
}
