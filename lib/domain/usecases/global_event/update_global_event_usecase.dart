import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateGlobalEventUseCase {
  final GlobalEventRepository repository;
  UpdateGlobalEventUseCase({required this.repository});
  Future<void> call(String id, GlobalEventModel model) async {
    try { await repository.update(id, model); } catch (e) { rethrow; }
  }
}

final updateGlobalEventUseCaseProvider = Provider<UpdateGlobalEventUseCase>((ref) =>
    UpdateGlobalEventUseCase(repository: ref.read(globalEventRepositoryProvider)));