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
}
