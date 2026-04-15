import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/user_datasource.dart';
import 'package:delivery_app/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDatasourceImpl extends BaseFirestoreDatasource<UserModel>
    implements UserDatasource {
  UserDatasourceImpl({required super.firestore})
      : super(collectionName: 'users');

  @override
  Future<List<UserModel>> getAll() async =>
      await fetchAll(UserModel.fromMap) ?? [];

  @override
  Future<UserModel?> getById(String id) async =>
      await findById(id, UserModel.fromMap);

  @override
  Future<void> create(UserModel model) async {
    try {
      await add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, UserModel model) async {
    try {
      await firestore.collection(collectionName).doc(id).update(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}

final userDatasourceProvider = Provider<UserDatasource>((ref) {
  return UserDatasourceImpl(firestore: ref.read(firebaseFirestoreProvider));
});
