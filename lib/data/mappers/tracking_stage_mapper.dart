import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';

class TrackingStageMapper extends BaseMapper<TrackingStage, TrackingStageModel> {
  @override
  TrackingStage? toEntity(TrackingStageModel? model) {
    if (model == null) return null;
    return TrackingStage(
        name: model.name, date: model.date, completed: model.completed);
  }

  @override
  TrackingStageModel? toModel(TrackingStage? entity) {
    if (entity == null) return null;
    return TrackingStageModel(
        name: entity.name, date: entity.date, completed: entity.completed);
  }
  
}