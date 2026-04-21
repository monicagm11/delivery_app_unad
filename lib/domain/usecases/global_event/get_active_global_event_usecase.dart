import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetActiveGlobalEventUsecase {
  final GlobalEventRepository repository;
  GetActiveGlobalEventUsecase({required this.repository});
  Future<List<GlobalEvent>> call() async {
    try { return await repository.getAllActive(); } catch (e) { rethrow; }
  }
}

final getActiveGlobalEventsUseCaseProvider = Provider<GetActiveGlobalEventUsecase>((ref) =>
    GetActiveGlobalEventUsecase(repository: ref.read(globalEventRepositoryProvider)));