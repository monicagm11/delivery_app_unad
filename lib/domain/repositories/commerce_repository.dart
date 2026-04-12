import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/domain/entities/commerce.dart';

abstract class CommerceRepository {
  Future<List<Commerce>> getAll();
  Future<Commerce?> getById(String id);
  Future<void> create(CommerceModel model);
  Future<void> update(String id, CommerceModel model);
  Future<void> delete(String id);
}
