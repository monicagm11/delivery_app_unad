import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/get_remote_config_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:delivery_app/presentation/notifier/session/session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionNotifier extends StateNotifier<SessionState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  final GetCommerceByIdUseCase getCommerceByIdUseCase;
  final GetRemoteConfigUsecase getRemoteConfigUsecase;
  SessionNotifier(
      {required this.getCommerceByIdUseCase,
      required this.getUserByIdUseCase,
      required this.getRemoteConfigUsecase})
      : super(const SessionState());

  Future<void> setSession(String userId) async {
    try {
      User? user = await getUserByIdUseCase.call(userId);
      if (user == null) return;
      Commerce? commerce;
      if (user.commerce != null && user.commerce!.isNotEmpty) {
        commerce = await getCommerceByIdUseCase.call(user.commerce!);
      }
      final rolInfo = await getRemoteConfigUsecase.call(user.rol);

      state = state.copyWith(
          userId: userId,
          email: user.email,
          commerceId: user.commerce,
          rol: user.rol,
          commerce: commerce,
          rolConfig: rolInfo);
    } catch (e) {
      state = state.copyWith(userId: userId);
    }
  }

  void clear() => state = const SessionState();
}

final sessionNotifierProvider =
    StateNotifierProvider<SessionNotifier, SessionState>(
  (ref) => SessionNotifier(
      getCommerceByIdUseCase: ref.read(getCommerceByIdUseCaseProvider),
      getUserByIdUseCase: ref.read(getUserByIdUseCaseProvider),
      getRemoteConfigUsecase: ref.read(getRemoteConfigUsecaseProvider)),
      
);
