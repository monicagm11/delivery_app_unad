import 'package:delivery_app/data/models/commerce_model.dart';

abstract class CommerceDatasource {
  Future<List<CommerceModel>> getAll();
  Future<CommerceModel?> getById(String id);
  Future<void> create(CommerceModel model);
  Future<void> update(String id, CommerceModel model);
  Future<void> delete(String id);
}
