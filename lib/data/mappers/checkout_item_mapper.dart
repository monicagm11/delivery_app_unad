import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/checkout_item_model.dart';
import 'package:delivery_app/domain/entities/checkout_item.dart';

class CheckoutItemMapper extends BaseMapper<CheckoutItem, CheckoutItemModel> {
  @override
  CheckoutItem toEntity(CheckoutItemModel model) {
    return CheckoutItem(
        priceTotal: model.priceTotal,
        valueIva: model.valueIva,
        percentageIva: model.percentageIva,
        priceBase: model.priceBase,
        idProduct: model.idProduct,
        nameProduct: model.nameProduct,
        count: model.count);
  }

  @override
  CheckoutItemModel toModel(CheckoutItem entity) {
    return CheckoutItemModel(
        priceTotal: entity.priceTotal,
        valueIva: entity.valueIva,
        percentageIva: entity.percentageIva,
        priceBase: entity.priceBase,
        idProduct: entity.idProduct,
        nameProduct: entity.nameProduct,
        count: entity.count);
  }

}