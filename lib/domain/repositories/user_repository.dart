import 'package:delivery_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAll();
  Future<User?> getById(String id);
  Future<List<User>> getByRolAndEventId(String rol, String eventId);
  Future<void> create(User model);
  Future<void> update(String id, User model);
  Future<void> updateCurrentEventId(String id, String? eventId);
  Future<void> delete(String id);
}
