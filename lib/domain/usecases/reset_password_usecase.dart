import 'package:delivery_app/domain/usecases/login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Envía un correo de recuperación de contraseña al email indicado.
class ResetPasswordUseCase {
  final FirebaseAuth auth;

  ResetPasswordUseCase({required this.auth});

  Future<void> call({required String email}) async {
    try {
      await auth.setLanguageCode('es');
      await auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _mapError(e.code);
    }
  }

  String _mapError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No existe una cuenta con este correo.';
      case 'invalid-email':
        return 'El correo ingresado no es válido.';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde.';
      default:
        return 'Error al enviar el correo. Intenta de nuevo.';
    }
  }
}

final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) {
  return ResetPasswordUseCase(auth: ref.read(firebaseAuthProvider));
});
