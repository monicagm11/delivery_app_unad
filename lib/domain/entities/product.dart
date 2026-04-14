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

  const Product({
    required this.id,
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
    required this.description
  });

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
        'description': description
      };
}
