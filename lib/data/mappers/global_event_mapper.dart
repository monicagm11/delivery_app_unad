import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:delivery_app/domain/entities/global_event.dart';

class GlobalEventMapper extends BaseMapper<GlobalEvent, GlobalEventModel> {
  @override
  GlobalEvent? toEntity(GlobalEventModel? model) {
    if (model == null) return null;
    return GlobalEvent(
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
        status: model.status);
  }

  @override
  GlobalEventModel? toModel(GlobalEvent? entity) {
    if (entity == null) return null;
    return GlobalEventModel(
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
        status: entity.status);
  }
  
}