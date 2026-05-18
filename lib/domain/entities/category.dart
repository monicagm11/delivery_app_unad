class Category {
  final String id;
  final String name;
  final String description;
  final String status;
  final String commerce;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.commerce,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'status': status,
        'commerce': commerce,
      };
  factory Category.fromMap(Map<String, dynamic> map) => Category(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        description: map['description'] as String? ?? '',
        status: map['status'] as String? ?? '',
        commerce: map['commerce'] as String? ?? '',
      );
}
