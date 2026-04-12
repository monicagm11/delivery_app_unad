import 'package:delivery_app/data/datasources/commerce_datasource.dart';
import 'package:delivery_app/data/datasources/commerce_datasource_impl.dart';
import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/repositories/commerce_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceRepositoryImpl implements CommerceRepository {
  final CommerceDatasource datasource;

  CommerceRepositoryImpl({required this.datasource});

  @override
  Future<List<Commerce>> getAll() async {
    try {
      return await datasource.getAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Commerce?> getById(String id) async {
    try {
      return await datasource.getById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(CommerceModel model) async {
    try {
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, CommerceModel model) async {
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

final commerceRepositoryProvider = Provider<CommerceRepository>((ref) {
  return CommerceRepositoryImpl(
    datasource: ref.read(commerceDatasourceProvider),
  );
});
