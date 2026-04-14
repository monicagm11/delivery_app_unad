import 'package:delivery_app/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.priceBase, 
    required super.percentageIva, 
    required super.valueIva, 
    required super.totalPrice, 
    required super.category, 
    required super.status,
    required super.commerce,
    required super.description,
    super.urlImage,
    super.time
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        priceBase: (map['priceBase'] as num?)?.toDouble() ?? 0.0,
        percentageIva: (map['percentageIva'] as num?)?.toDouble() ?? 0.0,
        valueIva: (map['valueIva'] as num?)?.toDouble() ?? 0.0,
        totalPrice: (map['totalPrice'] as num?)?.toDouble() ?? 0.0,
        category: map['category'] as String? ?? '',
        status: map['status'] as String? ?? '',
        urlImage:  map['urlImage'],
        time: map['time'],
        commerce: map['commerce'],
        description: map['description'] as String? ?? '',
      );

  
}
