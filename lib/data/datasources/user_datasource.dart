import 'package:delivery_app/data/models/user_model.dart';

abstract class UserDatasource {
  Future<List<UserModel>> getAll();
  Future<UserModel?> getById(String id);
  Future<void> create(UserModel model);
  Future<void> update(String id, UserModel model);
  Future<void> delete(String id);
}
