import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetGlobalEventByIdUseCase {
  final GlobalEventRepository repository;
  GetGlobalEventByIdUseCase({required this.repository});
  Future<GlobalEvent?> call(String id) async {
    try { return await repository.getById(id); } catch (e) { rethrow; }
  }
}

final getGlobalEventByIdUseCaseProvider = Provider<GetGlobalEventByIdUseCase>((ref) =>
    GetGlobalEventByIdUseCase(repository: ref.read(globalEventRepositoryProvider)));