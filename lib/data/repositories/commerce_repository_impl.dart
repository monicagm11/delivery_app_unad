import 'package:delivery_app/data/datasources/commerce_datasource.dart';
import 'package:delivery_app/data/datasources/commerce_datasource_impl.dart';
import 'package:delivery_app/data/mappers/commerce_mapper.dart';
import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/repositories/commerce_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceRepositoryImpl implements CommerceRepository {
  final CommerceDatasource datasource;
  final CommerceMapper _mapper = CommerceMapper();

  CommerceRepositoryImpl({required this.datasource});

  @override
  Future<List<Commerce>> getAll() async {
    try {
      List<CommerceModel> list = await datasource.getAll();
      return list.map((e)=> _mapper.toEntity(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Commerce?> getById(String id) async {
    try {
      CommerceModel? model = await datasource.getById(id);
      return model != null ? _mapper.toEntity(model) : null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(Commerce commerce) async {
    try {
      CommerceModel model = _mapper.toModel(commerce);
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, Commerce commerce) async {
    try {
      CommerceModel model = _mapper.toModel(commerce);
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
