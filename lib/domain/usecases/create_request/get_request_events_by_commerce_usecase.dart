
import 'package:delivery_app/data/repositories/request_event_repository_impl.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:delivery_app/domain/repositories/request_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetRequestEventsByCommerceUseCase {
  final RequestEventRepository repository;
  GetRequestEventsByCommerceUseCase({required this.repository});
  Future<List<RequestEvent>> call(String commerceId) async {
    try { return await repository.getByCommerce(commerceId); } catch (e) { rethrow; }
  }
}

final getRequestEventsByCommerceUseCaseProvider = Provider<GetRequestEventsByCommerceUseCase>((ref) =>
    GetRequestEventsByCommerceUseCase(repository: ref.read(requestEventRepositoryProvider)));
