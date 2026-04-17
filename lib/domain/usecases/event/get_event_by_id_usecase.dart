
import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetLocalEventByIdUseCase {
  final LocalEventRepository repository;
  GetLocalEventByIdUseCase({required this.repository});
  Future<LocalEvent?> call(String id) async {
    try { return await repository.getById(id); } catch (e) { rethrow; }
  }
}

final getLocalEventByIdUseCaseProvider = Provider<GetLocalEventByIdUseCase>((ref) =>
    GetLocalEventByIdUseCase(repository: ref.read(localEventRepositoryProvider)));
