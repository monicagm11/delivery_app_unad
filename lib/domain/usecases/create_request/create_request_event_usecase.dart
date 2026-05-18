import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:delivery_app/domain/repositories/request_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRequestEventUseCase {
  final RequestEventRepository repository;
  CreateRequestEventUseCase({required this.repository});
  Future<void> call(RequestEvent model) async {
    try { await repository.create(model); } catch (e) { rethrow; }
  }
}

final createRequestEventUseCaseProvider = Provider<CreateRequestEventUseCase>((ref) =>
    CreateRequestEventUseCase(repository: ref.read(requestEventRepositoryProvider)));
