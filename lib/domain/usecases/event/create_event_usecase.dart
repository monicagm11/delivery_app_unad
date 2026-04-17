
import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateLocalEventUseCase {
  final LocalEventRepository repository;
  CreateLocalEventUseCase({required this.repository});
  Future<void> call(LocalEventModel model) async {
    try { await repository.create(model); } catch (e) { rethrow; }
  }
}

final createLocalEventUseCaseProvider = Provider<CreateLocalEventUseCase>((ref) =>
    CreateLocalEventUseCase(repository: ref.read(localEventRepositoryProvider)));
