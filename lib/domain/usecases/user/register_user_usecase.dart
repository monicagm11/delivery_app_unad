import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterUserUsecase {
  final FirebaseAuth auth;

  RegisterUserUsecase({required this.auth});

  Future<UserCredential> call({
    required String email,
    required String password,
  }) async {
    try {
      return FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapError(e.code);
    }
  }

  String _mapError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No existe una cuenta con este correo.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada.';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde.';
      case 'email-already-in-use':
        return 'Usuario ya existe';
      default:
        return 'Error al iniciar sesión. Intenta de nuevo.';
    }
  }
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final registerUseCaseProvider = Provider<RegisterUserUsecase>((ref) {
  return RegisterUserUsecase(auth: ref.read(firebaseAuthProvider));
});
