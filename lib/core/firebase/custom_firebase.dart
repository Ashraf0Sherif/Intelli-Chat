import 'package:firebase_auth/firebase_auth.dart';

class CustomFirebase {
  Future<UserCredential> loginUser(
      {required String email, required String password}) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  Future<UserCredential> createUser(
      {required String email, required String password}) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
