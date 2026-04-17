import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllLocalEventsUseCase {
  final LocalEventRepository repository;
  GetAllLocalEventsUseCase({required this.repository});
  Future<List<LocalEvent>> call() async {
    try { return await repository.getAll(); } catch (e) { rethrow; }
  }
}

final getAllLocalEventsUseCaseProvider = Provider<GetAllLocalEventsUseCase>((ref) =>
    GetAllLocalEventsUseCase(repository: ref.read(localEventRepositoryProvider)));
