
class UserModel {
  UserModel({
    required this.id,
    required this.name,
    this.lastname,
    this.fullname,
    this.document,
    this.identificationType,
    this.fullDocument,
    this.phone,
    required this.email,
    this.address,
    required this.userId,
    required this.status,
    this.department,
    this.city, 
    required this.rol,
    this.commerce,
    this.occupation,
    this.currentEventId,
    this.token
  });

  final String id;
  final String name;
  final String? lastname;
  final String? fullname;
  final String? document;
  final String? identificationType;
  final String? fullDocument;
  final String? phone;
  final String email;
  final String? department;
  final String? city;
  final String? address;
  final String userId;
  final String status;
  final String? commerce;
  final String? occupation;
  final String rol;
  final String? currentEventId;
  final String? token;

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
        rol: map['rol'] as String? ?? '',
        commerce: map['commerce'] as String?,
        occupation: map['occupation'],
        currentEventId: map['currentEventId'] as String?,
        token: map['token'] as String?
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'name': name,
        'lastname': lastname,
        'fullname': fullname,
        'document': document,
        'identificationType': identificationType,
        'phone': phone,
        'address': address,
        'email': email,
        'status': status,
        'fullDocument': fullDocument,
        'department': department,
        'city': city,
        'commerce': commerce,
        'rol': rol,
        'occupation': occupation,
        'currentEventId': currentEventId,
        'token': token
      };
}
