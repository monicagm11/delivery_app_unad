import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:delivery_app/domain/repositories/request_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllRequestEventsUseCase {
  final RequestEventRepository repository;
  GetAllRequestEventsUseCase({required this.repository});
  Future<List<RequestEvent>> call() async {
    try { return await repository.getAll(); } catch (e) { rethrow; }
  }
}

final getAllRequestEventsUseCaseProvider = Provider<GetAllRequestEventsUseCase>((ref) =>
    GetAllRequestEventsUseCase(repository: ref.read(requestEventRepositoryProvider)));