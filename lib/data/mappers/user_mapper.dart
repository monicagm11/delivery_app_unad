import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/user_model.dart';
import 'package:delivery_app/domain/entities/user.dart';

class UserMapper extends BaseMapper<User, UserModel> {
  @override
  User? toEntity(UserModel? model) {
    if (model == null) return null;
    return User(
        id: model.id,
        name: model.name,
        lastname: model.lastname,
        fullname: model.fullname,
        document: model.document,
        identificationType: model.identificationType,
        fullDocument: model.fullDocument,
        phone: model.phone,
        email: model.email,
        department: model.department,
        city: model.city,
        address: model.address,
        userId: model.userId,
        status: model.status,
        commerce: model.commerce,
        occupation: model.occupation,
        rol: model.rol,
        currentEventId: model.currentEventId,
        token: model.token);
  }

  @override
  UserModel? toModel(User? entity) {
    if (entity == null) return null;
    return UserModel(
        id: entity.id,
        name: entity.name,
        lastname: entity.lastname,
        fullname: entity.fullname,
        document: entity.document,
        identificationType: entity.identificationType,
        fullDocument: entity.fullDocument,
        phone: entity.phone,
        email: entity.email,
        department: entity.department,
        city: entity.city,
        address: entity.address,
        userId: entity.userId,
        status: entity.status,
        commerce: entity.commerce,
        occupation: entity.occupation,
        rol: entity.rol,
        currentEventId: entity.currentEventId,
        token: entity.token);
  }
  
}