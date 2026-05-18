import 'package:delivery_app/data/mappers/base_mapper.dart';
import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/domain/entities/category.dart';

class CategoryMapper extends BaseMapper<Category, CategoryModel> {
  @override
  Category? toEntity(CategoryModel? model) {
    if (model == null) return null;
    return Category(
      id: model.id,
      name: model.name,
      description: model.description,
      status: model.status,
      commerce: model.commerce,
    );
  }

  @override
  CategoryModel? toModel(Category? entity) {
    if (entity == null) return null;
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      status: entity.description,
      commerce: entity.commerce,
    );
  }
}
