import 'package:delivery_app/domain/usecases/auth/login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Actualiza la contraseña del usuario actualmente autenticado.
/// Requiere reautenticación si la sesión es antigua.
class UpdatePasswordUseCase {
  final FirebaseAuth auth;

  UpdatePasswordUseCase({required this.auth});

  Future<void> call({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) throw 'No hay sesión activa.';

      // Reautenticar antes de cambiar la contraseña
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _mapError(e.code);
    }
  }

  String _mapError(String code) {
    switch (code) {
      case 'wrong-password':
      case 'invalid-credential':
        return 'La contraseña actual es incorrecta.';
      case 'weak-password':
        return 'La nueva contraseña es muy débil. Usa al menos 6 caracteres.';
      case 'requires-recent-login':
        return 'Sesión expirada. Vuelve a iniciar sesión e intenta de nuevo.';
      default:
        return 'Error al actualizar la contraseña. Intenta de nuevo.';
    }
  }
}

final updatePasswordUseCaseProvider = Provider<UpdatePasswordUseCase>((ref) {
  return UpdatePasswordUseCase(auth: ref.read(firebaseAuthProvider));
});
