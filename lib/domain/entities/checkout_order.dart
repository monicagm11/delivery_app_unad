import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';

class CheckoutOrder {
  final String userId;
  final String eventId;
  final String? urlImage;
  final String? change;
  final String? comments;
  final String commerce;
  final PaymentMethod paymentMethod;
  final List<CheckoutItem> checkoutItems;
  final List<TrackingStage> stageList;
  final double total;

  CheckoutOrder(
      {required this.userId,
      required this.eventId,
      this.urlImage,
      this.change,
      required this.commerce,
      required this.comments,
      required this.paymentMethod,
      required this.checkoutItems,
      required this.total,
      required this.stageList});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'eventId': eventId,
      'urlImage': urlImage,
      'change': change,
      'comments': comments,
      'commerce': commerce,
      'paymentMethod': paymentMethod.name,
      'checkoutItems': checkoutItems.map((e) => e.toMap()).toList(),
      'stageList': stageList.map((e) => e.toMap()).toList(),
      'total': total
    };
  }
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
        name: map['name'], date: map['date'], completed: map['completed']);
  }
}
