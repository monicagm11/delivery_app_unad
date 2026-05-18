import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateGlobalEventUseCase {
  final GlobalEventRepository repository;
  CreateGlobalEventUseCase({required this.repository});
  Future<void> call(GlobalEvent model) async {
    try { await repository.create(model); } catch (e) { rethrow; }
  }
}

final createGlobalEventUseCaseProvider = Provider<CreateGlobalEventUseCase>((ref) =>
    CreateGlobalEventUseCase(repository: ref.read(globalEventRepositoryProvider)));