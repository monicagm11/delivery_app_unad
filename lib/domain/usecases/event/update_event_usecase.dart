import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateLocalEventUseCase {
  final LocalEventRepository repository;
  UpdateLocalEventUseCase({required this.repository});
  Future<void> call(String id, LocalEvent model) async {
    try { await repository.update(id, model); } catch (e) { rethrow; }
  }
}

final updateLocalEventUseCaseProvider = Provider<UpdateLocalEventUseCase>((ref) =>
    UpdateLocalEventUseCase(repository: ref.read(localEventRepositoryProvider)));