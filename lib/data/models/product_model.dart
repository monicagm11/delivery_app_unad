
class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.priceBase, 
    required this.percentageIva, 
    required this.valueIva, 
    required this.totalPrice, 
    required this.category, 
    required this.status,
    required this.commerce,
    required this.description,
    this.urlImage,
    this.time,
    this.categoryName
  });

  final String id;
  final String name;
  final double priceBase;
  final double percentageIva;
  final double valueIva;
  final double totalPrice;
  final String? urlImage;
  final String category;
  final String? time;
  final String status;
  final String commerce;
  final String description;
  final String? categoryName;

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
        categoryName: map['categoryName'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'priceBase': priceBase,
        'percentageIva': percentageIva,
        'valueIva': valueIva,
        'totalPrice': totalPrice,
        'category': category,
        'status': status,
        'urlImage': urlImage,
        'time': time,
        'commerce': commerce,
        'description': description,
        'categoryName': categoryName
      };
}
