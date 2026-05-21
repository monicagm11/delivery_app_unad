import 'package:delivery_app/domain/usecases/auth/login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginGoogleUsecase {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  LoginGoogleUsecase({required this.auth, required this.googleSignIn});

  Future<UserCredential> call() async {
    try {
       if (kIsWeb) {
      final provider = GoogleAuthProvider();

      return await auth.signInWithPopup(
        provider,
      );
    }

    final googleUser = await googleSignIn.authenticate();

    final googleAuth = googleUser.authentication;

    final credential =
        GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(
      credential,
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
      default:
        return 'Error al iniciar sesión. Intenta de nuevo.';
    }
  }
}
final googleSignInProvider =
    Provider<GoogleSignIn>((ref) => GoogleSignIn.instance);

final loginGoogleUseCaseProvider = Provider<LoginGoogleUsecase>((ref) {
  return LoginGoogleUsecase(
      auth: ref.read(firebaseAuthProvider),
      googleSignIn: ref.read(googleSignInProvider));
});
