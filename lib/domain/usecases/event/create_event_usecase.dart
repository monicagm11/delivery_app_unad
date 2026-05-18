import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateLocalEventUseCase {
  final LocalEventRepository repository;
  CreateLocalEventUseCase({required this.repository});
  Future<void> call(LocalEvent model) async {
    try { await repository.create(model); } catch (e) { rethrow; }
  }
}

final createLocalEventUseCaseProvider = Provider<CreateLocalEventUseCase>((ref) =>
    CreateLocalEventUseCase(repository: ref.read(localEventRepositoryProvider)));
