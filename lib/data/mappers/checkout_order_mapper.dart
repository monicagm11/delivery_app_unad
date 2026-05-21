import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/mappers/checkout_item_mapper.dart';
import 'package:delivery_app/data/mappers/tracking_stage_mapper.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';

class CheckoutOrderMapper extends BaseMapper<CheckoutOrder, CheckoutOrderModel>{
  final CheckoutItemMapper _checkoutItemMapper = CheckoutItemMapper();
  final TrackingStageMapper _trackingStageMapper = TrackingStageMapper();
  @override
  CheckoutOrder? toEntity(CheckoutOrderModel? model) {
    if (model == null) return null;
    return CheckoutOrder(
        id: model.id,
        userId: model.userId,
        eventId: model.eventId,
        commerce: model.commerce,
        comments: model.comments,
        paymentMethod: PaymentMethod.values.firstWhere(
          (e) => e.name == model.paymentMethod,
          orElse: () => PaymentMethod.cash,
        ),
        checkoutItems: model.checkoutItems.map((e) => _checkoutItemMapper.toEntity(e)!).toList(),
        total: model.total,
        stageList: model.stageList.map((e) => _trackingStageMapper.toEntity(e)!).toList(),
        urlImage: model.urlImage,
        change: model.change,
        location: model.location,
        userName: model.userName,
        idDeliveryAssigned: model.idDeliveryAssigned);
  }

  @override
  CheckoutOrderModel? toModel(CheckoutOrder? entity) {
    if (entity == null) return null;
    return CheckoutOrderModel(
        id: entity.id,
        userId: entity.userId,
        eventId: entity.eventId,
        commerce: entity.commerce,
        comments: entity.comments,
        paymentMethod: entity.paymentMethod.name,
        checkoutItems: entity.checkoutItems.map((e) => _checkoutItemMapper.toModel(e)!).toList(),
        total: entity.total,
        stageList: entity.stageList.map((e) => _trackingStageMapper.toModel(e)!).toList(),
        urlImage: entity.urlImage,
        change: entity.change,
        location: entity.location,
        userName: entity.userName,
        idDeliveryAssigned: entity.idDeliveryAssigned);
  }
}