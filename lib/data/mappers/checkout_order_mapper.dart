import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';

class CheckoutOrderMapper {
  static CheckoutOrder toEntity(CheckoutOrderModel model) {
    return CheckoutOrder(
        id: model.id,
        userId: model.userId,
        eventId: model.eventId,
        commerce: model.commerce,
        comments: model.comments,
        paymentMethod: model.paymentMethod,
        checkoutItems: model.checkoutItems,
        total: model.total,
        stageList: model.stageList,
        urlImage: model.urlImage,
        change: model.change,
        location: model.location,
        userName: model.userName);
  }

  static CheckoutOrderModel toModel(CheckoutOrder entity) {
    return CheckoutOrderModel(
        id: entity.id,
        userId: entity.userId,
        eventId: entity.eventId,
        commerce: entity.commerce,
        comments: entity.comments,
        paymentMethod: entity.paymentMethod,
        checkoutItems: entity.checkoutItems,
        total: entity.total,
        stageList: entity.stageList,
        urlImage: entity.urlImage,
        change: entity.change,
        location: entity.location,
        userName: entity.userName);
  }
}