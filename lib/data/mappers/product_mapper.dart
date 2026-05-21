import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/product_model.dart';
import 'package:delivery_app/domain/entities/product.dart';

class ProductMapper extends BaseMapper<Product, ProductModel> {
  @override
  Product? toEntity(ProductModel? model) {
    if (model == null) return null;
    return Product(
        id: model.id,
        name: model.name,
        priceBase: model.priceBase,
        percentageIva: model.percentageIva,
        valueIva: model.valueIva,
        totalPrice: model.totalPrice,
        category: model.category,
        status: model.status,
        commerce: model.commerce,
        description: model.description,
        urlImage: model.urlImage,
        time: model.time,
        categoryName: model.categoryName
        );
  }

  @override
  ProductModel? toModel(Product? entity) {
    if (entity == null) return null;
    return ProductModel(
        id: entity.id,
        name: entity.name,
        priceBase: entity.priceBase,
        percentageIva: entity.percentageIva,
        valueIva: entity.valueIva,
        totalPrice: entity.totalPrice,
        category: entity.category,
        status: entity.status,
        commerce: entity.commerce,
        description: entity.description,
        urlImage: entity.urlImage,
        time: entity.time,
        categoryName: entity.categoryName
        );
  }

}