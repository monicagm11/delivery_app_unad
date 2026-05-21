import 'dart:convert';

import 'package:delivery_app/domain/entities/rol.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetRemoteConfigUsecase {
  final FirebaseRemoteConfig remoteConfig;

  GetRemoteConfigUsecase({required this.remoteConfig});

  Future<Rol?> call(String rol) async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();

    final String jsonString = remoteConfig.getString('ROLES');
    if (jsonString.isEmpty) return null;
    final Map<String, dynamic> globalMap = jsonDecode(jsonString);
    final Map<String, dynamic>? rolConfig = globalMap[rol];
    if (rolConfig == null) return null;
    return Rol.fromMap(rolConfig);
  }
}

final firebaseRemoteConfigProvider =
    Provider<FirebaseRemoteConfig>((ref) => FirebaseRemoteConfig.instance);

final getRemoteConfigUsecaseProvider = Provider<GetRemoteConfigUsecase>((ref) {
  return GetRemoteConfigUsecase(remoteConfig: ref.read(firebaseRemoteConfigProvider));
});
