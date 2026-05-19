import 'package:delivery_app/data/repositories/global_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetGlobalEventByCityUsecase {
  final GlobalEventRepository repository;
  GetGlobalEventByCityUsecase({required this.repository});
  Future<List<GlobalEvent>> call(String city, String department) async {
    try {
      return await repository.getActiveByCity(city, department);
    } catch (e) {
      rethrow;
    }
  }
}

final getGlobalEventByCityUseCaseProvider = Provider<GetGlobalEventByCityUsecase>((ref) =>
    GetGlobalEventByCityUsecase(repository: ref.read(globalEventRepositoryProvider)));