import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateCurrentEventIdUseCase {
  final UserRepository repository;
  UpdateCurrentEventIdUseCase({required this.repository});

  Future<void> call(String userId, String? eventId) async {
    try {
      await repository.updateCurrentEventId(userId, eventId);
    } catch (e) {
      rethrow;
    }
  }
}

final updateCurrentEventIdUseCaseProvider =
    Provider<UpdateCurrentEventIdUseCase>((ref) => UpdateCurrentEventIdUseCase(
        repository: ref.read(userRepositoryProvider)));
