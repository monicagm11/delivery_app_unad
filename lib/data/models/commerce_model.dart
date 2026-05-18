
class CommerceModel {
  const CommerceModel({
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
    required this.urlImage,
    required this.urlImageQR,
    required this.fullDocument
  });

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
  final String urlImage;
  final String urlImageQR;

  factory CommerceModel.fromMap(Map<String, dynamic> map) => CommerceModel(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        document: map['document'] as String? ?? '',
        identificationType: map['identificationType'] as String? ?? '',
        phone: map['phone'] as String? ?? '',
        address: map['address'] as String? ?? '',
        email: map['email'] as String? ?? '',
        department: map['department'] as String? ?? '',
        city: map['city'] as String? ?? '',
        status: map['status'] as String? ?? '',
        contactName: map['contactName'] as String? ?? '',
        fullDocument: '${map['identificationType']} ${map['document']}',
        urlImage:  map['urlImage'] as String? ?? '',
        urlImageQR:  map['urlImageQR'] as String? ?? '',
      );
      
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
        'fullDocument': fullDocument,
        'urlImage': urlImage,
        'urlImageQR': urlImageQR
      };
}
