import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:delivery_app/domain/entities/local_event.dart';

class LocalEventMapper extends BaseMapper<LocalEvent, LocalEventModel> {
  @override
  LocalEvent? toEntity(LocalEventModel? model) {
    if (model == null) return null;
    return LocalEvent(
        id: model.id,
        name: model.name,
        description: model.description,
        longitude: model.longitude,
        latitude: model.latitude,
        radious: model.radious,
        scheduleDate: model.scheduleDate,
        startDate: model.startDate,
        endDate: model.endDate,
        department: model.department,
        city: model.city,
        status: model.status,
        productsIdList: model.productsIdList,
        commerce: model.commerce,
        locationClientType: model.locationClientType,
        idGlobalEvent: model.idGlobalEvent);
  }

  @override
  LocalEventModel? toModel(LocalEvent? entity) {
    if (entity == null) return null;
    return LocalEventModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        longitude: entity.longitude,
        latitude: entity.latitude,
        radious: entity.radious,
        scheduleDate: entity.scheduleDate,
        startDate: entity.startDate,
        endDate: entity.endDate,
        department: entity.department,
        city: entity.city,
        status: entity.status,
        productsIdList: entity.productsIdList,
        commerce: entity.commerce,
        locationClientType: entity.locationClientType,
        idGlobalEvent: entity.idGlobalEvent);
  }
}
