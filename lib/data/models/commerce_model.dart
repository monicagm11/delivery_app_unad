import 'package:delivery_app/domain/entities/commerce.dart';

class CommerceModel extends Commerce {
  const CommerceModel({
    required super.id,
    required super.name,
    required super.document,
    required super.identificationType,
    required super.phone,
    required super.address,
    required super.email,
    required super.department,
    required super.city,
    required super.status,
    required super.contactName,
    required super.urlImage,
    required super.urlImageQR,
    super.fullDocument
  });

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
}
