
class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.commerce,
  });

  final String id;
  final String name;
  final String description;
  final String status;
  final String commerce;

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        description: map['description'] as String? ?? '',
        status: map['status'] as String? ?? '',
        commerce: map['commerce'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'status': status,
        'commerce': commerce,
      };
}
