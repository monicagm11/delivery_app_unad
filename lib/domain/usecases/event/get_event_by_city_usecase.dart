import 'package:delivery_app/data/repositories/local_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetEventByCityUsecase {
  final LocalEventRepository repository;
  GetEventByCityUsecase({required this.repository});
  Future<List<LocalEvent>> call(String city, String department) async {
    try {
      return await repository.getActiveByCity(city, department);
    } catch (e) {
      rethrow;
    }
  }
}

final getEventByCityUseCaseProvider = Provider<GetEventByCityUsecase>((ref) =>
    GetEventByCityUsecase(repository: ref.read(localEventRepositoryProvider)));
