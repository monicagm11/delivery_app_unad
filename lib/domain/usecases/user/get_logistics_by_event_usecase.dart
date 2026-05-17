import 'package:delivery_app/data/repositories/user_repository_impl.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetLogisticsByEventUseCase {
  final UserRepository repository;
  GetLogisticsByEventUseCase({required this.repository});

  /// Retorna los usuarios con rol LOGISTICO cuyo [currentEventId] == [eventId].
  Future<List<User>> call(String eventId) async {
    try {
      return await repository.getByRolAndEventId(
          Constants.logisticRolCode, eventId);
    } catch (e) {
      rethrow;
    }
  }
}

final getLogisticsByEventUseCaseProvider =
    Provider<GetLogisticsByEventUseCase>((ref) => GetLogisticsByEventUseCase(
        repository: ref.read(userRepositoryProvider)));

/// FutureProvider.family para obtener logísticos por eventId.
final logisticsByEventProvider =
    FutureProvider.family<List<User>, String>((ref, eventId) async {
  return ref.read(getLogisticsByEventUseCaseProvider).call(eventId);
});
