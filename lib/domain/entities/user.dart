class User {
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

  User(
      {required this.id, 
      required this.name,
      this.lastname,
      this.fullname,
      this.document,
      this.identificationType,
      this.fullDocument,
      this.phone,
      required this.email,
      this.department,
      this.city,
      this.address,
      required this.userId,
      required this.status,
      this.commerce,
      this.occupation,
      required this.rol,
      this.currentEventId});

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
      };
}
