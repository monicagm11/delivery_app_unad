import 'package:delivery_app/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    super.lastname,
    super.fullname,
    super.document,
    super.identificationType,
    super.fullDocument,
    super.phone,
    required super.email,
    super.address,
    required super.userId,
    required super.status,
    super.department,
    super.city, 
    required super.rol
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        lastname: map['lastname'] as String? ?? '',
        fullname: '${map['name']} ${map['lastname']}',
        document: map['document'] as String? ?? '',
        identificationType: map['identificationType'] as String? ?? '',
        fullDocument: '${map['identificationType']} ${map['document']}',
        phone: map['phone'] as String? ?? '',
        email: map['email'] as String? ?? '',
        address: map['address'] as String? ?? '',
        userId: map['userId'] as String? ?? '',
        status: map['status'] as String? ?? '',
        department: map['department'] as String? ?? '',
        city: map['city'] as String? ?? '',
        rol: map['rol'] as String? ?? ''
      );
}
