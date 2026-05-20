import 'package:delivery_app/data/datasources/user_datasource.dart';
import 'package:delivery_app/data/datasources/user_datasource_impl.dart';
import 'package:delivery_app/data/mappers/user_mapper.dart';
import 'package:delivery_app/data/models/user_model.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;
  final UserMapper _mapper = UserMapper();

  UserRepositoryImpl({required this.datasource});

  @override
  Future<List<User>> getAll() async {
    try {
      List<UserModel> list = await datasource.getAll();
      return list.map((e) => _mapper.toEntity(e)!).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getById(String id) async {
    try {
      UserModel? model = await datasource.getById(id);
      return _mapper.toEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(User user) async {
    try {
      UserModel model = _mapper.toModel(user)!;
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> getByRolAndEventId(String rol, String eventId) async {
    try {
      List<UserModel> list = await datasource.getByRolAndEventId(rol, eventId);
      return list.map((e) => _mapper.toEntity(e)!).toList();
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
  Future<void> update(String id, User user) async {
    try {
      UserModel model = _mapper.toModel(user)!;
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
