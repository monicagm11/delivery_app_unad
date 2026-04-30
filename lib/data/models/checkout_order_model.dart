import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';

class CheckoutOrderModel extends CheckoutOrder {

  CheckoutOrderModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.eventId,
    super.urlImage,
    super.change,
    required super.comments,
    required super.paymentMethod,
    required super.checkoutItems,
    required super.commerce,
    required super.total,
    required super.stageList,
    required super.location,
    super.idDeliveryAssigned,
  });

  factory CheckoutOrderModel.fromMap(Map<String, dynamic> map) =>
      CheckoutOrderModel(
        id: map['id'] as String? ?? '',
        userId: map['userId'] as String? ?? '',
        eventId: map['eventId'] as String? ?? '',
        urlImage: map['urlImage'] as String?,
        change: map['change'] as String?,
        comments: map['comments'] as String? ?? '',
        commerce: map['commerce'] as String? ?? '',
        total: map['total'] as double? ?? 0.0,
        idDeliveryAssigned: map['idDeliveryAssigned'] as String?,
        paymentMethod: PaymentMethod.values.firstWhere(
          (e) => e.name == map['paymentMethod'],
          orElse: () => PaymentMethod.cash,
        ),
        checkoutItems: (map['checkoutItems'] as List<dynamic>? ?? [])
            .map((e) => CheckoutItem.fromMap(e as Map<String, dynamic>))
            .toList(),
        stageList: (map['stageList'] as List<dynamic>? ?? [])
            .map((e) => TrackingStage.fromMap(e as Map<String, dynamic>))
            .toList(),
        location: map['location'] as String? ?? '',
        userName: map['userName']
      );

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
      };
}
