import 'package:delivery_app/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.status,
    required super.commerce,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        description: map['description'] as String? ?? '',
        status: map['status'] as String? ?? '',
        commerce: map['commerce'] as String? ?? '',
      );
}
