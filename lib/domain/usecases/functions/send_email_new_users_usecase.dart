import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendEmailNewUsersUsecase {
  final FirebaseFunctions firebaseFunctions;

  const SendEmailNewUsersUsecase({required this.firebaseFunctions});

  Future<String> call({required String email, required String name}) async {
    final result = await firebaseFunctions
        .httpsCallable('createUser')
        .call({'email': email, 'name': name});
    return result.data['uid'] as String;
  }
}

final firebaseFunctionsProvider =
    Provider<FirebaseFunctions>((ref) => FirebaseFunctions.instance);

final sendEmailNewUsersUseCaseProvider = Provider<SendEmailNewUsersUsecase>((ref) {
  return SendEmailNewUsersUsecase(firebaseFunctions: ref.read(firebaseFunctionsProvider));
});