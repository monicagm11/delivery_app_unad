import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/menu_item.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/get_remote_config_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:delivery_app/presentation/notifier/session/session_state.dart';
import 'package:delivery_app/presentation/screens/settings_screen.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
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
          userName: user.fullname,
          commerce: commerce,
          rolConfig: rolInfo,
          rolId: user.rol);
    } catch (e) {
      state = state.copyWith(userId: userId);
    }
  }

  List<MenuItem> getMenuItems() {
    if (state.rolConfig == null) return [];
    final originalMapConfig = state.rolConfig!.functionConfig;
    final originalList = Constants.menuItems;
    List<MenuItem> items = originalList.where((obj1) {
      final obj2 = originalMapConfig[obj1.code];
      return obj2 != null && obj2.enabled;
    }).toList();
    items.add(MenuItem(
        title: 'Configuración',
        icon: Icons.settings,
        screen: SettingsScreen(),
        code: Constants.settingsFunction));
    return items;
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
