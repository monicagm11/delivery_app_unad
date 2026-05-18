import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/domain/entities/commerce.dart';

class CommerceMapper extends BaseMapper<Commerce, CommerceModel> {
  @override
  Commerce? toEntity(CommerceModel? model) {
    if (model == null) return null;
    return Commerce(id: model.id, 
    name: model.name, 
    document: model.document, 
    identificationType: model.identificationType, 
    phone: model.phone, 
    address: model.address, 
    email: model.email, 
    department: model.department, 
    city: model.city, 
    status: model.status, 
    contactName: model.contactName, 
    urlImage: model.urlImage, 
    urlImageQR: model.urlImageQR,
    fullDocument: model.fullDocument);
  }

  @override
  CommerceModel? toModel(Commerce? entity) {
    if (entity == null) return null;
    return CommerceModel(id: entity.id, 
    name: entity.name, 
    document: entity.document, 
    identificationType: entity.identificationType, 
    phone: entity.phone, 
    address: entity.address, 
    email: entity.email, 
    department: entity.department, 
    city: entity.city, 
    status: entity.status, 
    contactName: entity.contactName, 
    urlImage: entity.urlImage, 
    urlImageQR: entity.urlImageQR,
    fullDocument: entity.fullDocument);
  }
  
  
}