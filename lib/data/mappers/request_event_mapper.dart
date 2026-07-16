import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/request_event_model.dart';
import 'package:delivery_app/domain/entities/request_event.dart';

class RequestEventMapper extends BaseMapper<RequestEvent, RequestEventModel> {
  @override
  RequestEvent? toEntity(RequestEventModel? model) {
    if (model == null) return null;
    return RequestEvent(
        id: model.id,
        commerceId: model.commerceId,
        commerceName: model.commerceName,
        status: model.status,
        eventId: model.eventId,
        creationDate: model.creationDate,
        productsIdList: model.productsIdList,
        locationClientType: model.locationClientType);
  }

  @override
  RequestEventModel? toModel(RequestEvent? entity) {
    if (entity == null) return null;
    return RequestEventModel(
        id: entity.id,
        commerceId: entity.commerceId,
        commerceName:entity.commerceName,
        status: entity.status,
        eventId: entity.eventId,
        creationDate: entity.creationDate,
        productsIdList: entity.productsIdList,
        locationClientType: entity.locationClientType);
  }
  
}