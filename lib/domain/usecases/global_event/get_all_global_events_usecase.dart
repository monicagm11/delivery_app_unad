import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllGlobalEventsUseCase {
  final GlobalEventRepository repository;
  GetAllGlobalEventsUseCase({required this.repository});
  Future<List<GlobalEvent>> call() async {
    try { return await repository.getAll(); } catch (e) { rethrow; }
  }
}

final getAllGlobalEventsUseCaseProvider = Provider<GetAllGlobalEventsUseCase>((ref) =>
    GetAllGlobalEventsUseCase(repository: ref.read(globalEventRepositoryProvider)));