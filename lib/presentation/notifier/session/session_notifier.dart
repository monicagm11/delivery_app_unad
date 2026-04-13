import 'package:delivery_app/presentation/notifier/session/session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier() : super(const SessionState());

  void setSession(String userId, String email, String commerceId, String rol) {
    state = state.copyWith(userId: userId, email: email, commerceId: commerceId, rol: rol);
  }

  void clear() => state = const SessionState();
}

final sessionNotifierProvider =
    StateNotifierProvider<SessionNotifier, SessionState>(
  (ref) => SessionNotifier(),
);