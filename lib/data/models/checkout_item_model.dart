class CheckoutItemModel {
  final double priceTotal;
  final double valueIva;
  final double percentageIva;
  final double priceBase;
  final String idProduct;
  final String nameProduct;
  final int count;

  const CheckoutItemModel(
      {required this.priceTotal,
      required this.valueIva,
      required this.percentageIva,
      required this.priceBase,
      required this.idProduct,
      required this.nameProduct,
      required this.count});

  Map<String, dynamic> toMap() {
    return {
      'priceTotal': priceTotal,
      'valueIva': valueIva,
      'percentageIva': percentageIva,
      'priceBase': priceBase,
      'idProduct': idProduct,
      'nameProduct': nameProduct,
      'count': count
    };
  }

  factory CheckoutItemModel.fromMap(Map<String, dynamic> map) => CheckoutItemModel(
        priceTotal: (map['priceTotal'] as num?)?.toDouble() ?? 0.0,
        valueIva: (map['valueIva'] as num?)?.toDouble() ?? 0.0,
        percentageIva: (map['percentageIva'] as num?)?.toDouble() ?? 0.0,
        priceBase: (map['priceBase'] as num?)?.toDouble() ?? 0.0,
        idProduct: map['idProduct'] as String? ?? '',
        nameProduct: map['nameProduct'] as String? ?? '',
        count: map['count'] as int? ?? 0,
      );
}