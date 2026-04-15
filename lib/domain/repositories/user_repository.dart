import 'package:delivery_app/data/models/user_model.dart';
import 'package:delivery_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAll();
  Future<User?> getById(String id);
  Future<void> create(UserModel model);
  Future<void> update(String id, UserModel model);
  Future<void> delete(String id);
}
