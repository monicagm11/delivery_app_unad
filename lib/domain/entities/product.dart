class Product {
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

  const Product(
      {required this.id,
      required this.name,
      required this.priceBase,
      required this.percentageIva,
      required this.valueIva,
      required this.totalPrice,
      this.urlImage,
      required this.category,
      this.time,
      required this.status,
      required this.commerce,
      required this.description,
      this.categoryName});

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

  Product copyWith(
      {String? id,
      String? name,
      double? priceBase,
      double? percentageIva,
      double? valueIva,
      double? totalPrice,
      String? urlImage,
      String? category,
      String? time,
      String? status,
      String? commerce,
      String? description,
      String? categoryName}) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        priceBase: priceBase ?? this.priceBase,
        percentageIva: percentageIva ?? this.percentageIva,
        valueIva: valueIva ?? this.valueIva,
        totalPrice: totalPrice ?? this.totalPrice,
        urlImage: urlImage ?? this.urlImage,
        category: category ?? this.category,
        time: time ?? this.time,
        status: status ?? this.status,
        commerce: commerce ?? this.commerce,
        description: description ?? this.description,
        categoryName: categoryName ?? this.categoryName);
  }
}
