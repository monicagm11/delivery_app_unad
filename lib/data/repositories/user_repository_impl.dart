import 'package:delivery_app/data/datasources/user_datasource.dart';
import 'package:delivery_app/data/datasources/user_datasource_impl.dart';
import 'package:delivery_app/data/models/user_model.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl({required this.datasource});

  @override
  Future<List<User>> getAll() async {
    try {
      return await datasource.getAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getById(String id) async {
    try {
      return await datasource.getById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(UserModel model) async {
    try {
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> getByRolAndEventId(String rol, String eventId) async {
    try {
      return await datasource.getByRolAndEventId(rol, eventId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCurrentEventId(String id, String? eventId) async {
    try {
      await datasource.updateCurrentEventId(id, eventId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, UserModel model) async {
    try {
      await datasource.update(id, model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await datasource.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(datasource: ref.read(userDatasourceProvider));
});
