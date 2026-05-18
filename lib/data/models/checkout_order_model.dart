import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/models/checkout_item_model.dart';

class CheckoutOrderModel{

  CheckoutOrderModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.eventId,
    this.urlImage,
    this.change,
    required this.comments,
    required this.paymentMethod,
    required this.checkoutItems,
    required this.commerce,
    required this.total,
    required this.stageList,
    required this.location,
    this.idDeliveryAssigned,
  });

  final String? id;
  final String userId;
  final String userName;
  final String eventId;
  final String? urlImage;
  final String? change;
  final String? comments;
  final String commerce;
  final String paymentMethod;
  final List<CheckoutItemModel> checkoutItems;
  final List<TrackingStageModel> stageList;
  final double total;
  final String location;
  final String? idDeliveryAssigned;

  factory CheckoutOrderModel.fromMap(Map<String, dynamic> map) =>
      CheckoutOrderModel(
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
            .map((e) => CheckoutItemModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        stageList: (map['stageList'] as List<dynamic>? ?? [])
            .map((e) => TrackingStageModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        location: map['location'] as String? ?? '',
        userName: map['userName'] as String? ?? ''
      );

  Map<String, dynamic> toMap() => {
        'id': id,
      'userId': userId,
      'eventId': eventId,
      'urlImage': urlImage,
      'change': change,
      'comments': comments,
      'commerce': commerce,
      'paymentMethod': paymentMethod,
      'checkoutItems': checkoutItems.map((e) => e.toMap()).toList(),
      'stageList': stageList.map((e) => e.toMap()).toList(),
      'total': total,
      'location': location,
      'idDeliveryAssigned': idDeliveryAssigned,
      'userName': userName
      };
}

class TrackingStageModel {
  final String name;
  final DateTime? date;
  final bool completed;

  const TrackingStageModel({
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

  factory TrackingStageModel.fromMap(Map<String, dynamic> map) {
    return TrackingStageModel(
        name: map['name'], 
        date: (map['date'] as Timestamp?)?.toDate(),
        completed: map['completed']);
  }
}
