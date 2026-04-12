class Commerce {
  final String id;
  final String name;
  final String document;
  final String identificationType;
  final String phone;
  final String address;
  final String email;
  final String department;
  final String city;
  final String status;
  final String fullDocument;
  final String contactName;

  const Commerce({
    required this.id,
    required this.name,
    required this.document,
    required this.identificationType,
    required this.phone,
    required this.address,
    required this.email,
    required this.department,
    required this.city,
    required this.status,
    required this.contactName,
    this.fullDocument = ''
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'document': document,
        'identificationType': identificationType,
        'phone': phone,
        'address': address,
        'email': email,
        'department': department,
        'city': city,
        'status': status,
        'contactName': contactName,
        'fullDocument': fullDocument
      };
}
