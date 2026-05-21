import 'package:cloud_functions/cloud_functions.dart';
import 'package:delivery_app/domain/usecases/functions/send_email_new_users_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendPushNotificationUseCase {
  final FirebaseFunctions functions;

  const SendPushNotificationUseCase({required this.functions});

  /// [tokens]  : lista de FCM tokens destino
  /// [title]   : título de la notificación
  /// [body]    : cuerpo del mensaje
  /// [data]    : payload adicional (opcional)
  Future<({int successCount, int failureCount, List<String> failedTokens})>
      call({
    required List<String> tokens,
    required String title,
    required String body,
    Map<String, String> data = const {},
  }) async {
    try {
      final result = await functions.httpsCallable('sendPushNotification').call({
        'tokens': tokens,
        'title': title,
        'body': body,
        'data': data,
      });

      return (
        successCount: result.data['successCount'] as int,
        failureCount: result.data['failureCount'] as int,
        failedTokens: List<String>.from(result.data['failedTokens'] ?? []),
      );
    } on FirebaseFunctionsException catch (e) {
      throw '${e.message}';
    }
  }
}

final sendPushNotificationUseCaseProvider =
    Provider<SendPushNotificationUseCase>((ref) {
  return SendPushNotificationUseCase(
      functions: ref.read(firebaseFunctionsProvider));
});
