import 'package:delivery_app/data/models/request_event_model.dart';
import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/repositories/request_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateRequestEventUseCase {
  final RequestEventRepository repository;
  UpdateRequestEventUseCase({required this.repository});
  Future<void> call(String id, RequestEventModel model) async {
    try { await repository.update(id, model); } catch (e) { rethrow; }
  }
}

final updateRequestEventUseCaseProvider = Provider<UpdateRequestEventUseCase>((ref) =>
    UpdateRequestEventUseCase(repository: ref.read(requestEventRepositoryProvider)));
