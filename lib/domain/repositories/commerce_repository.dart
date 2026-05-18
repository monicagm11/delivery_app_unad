import 'package:delivery_app/domain/entities/commerce.dart';

abstract class CommerceRepository {
  Future<List<Commerce>> getAll();
  Future<Commerce?> getById(String id);
  Future<void> create(Commerce model);
  Future<void> update(String id, Commerce model);
  Future<void> delete(String id);
}
