import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomFirebase {
  Future<UserCredential> loginUsingEmailAndPassword(
      {required String email, required String password}) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  Future<UserCredential> loginUsingGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signupUsingEmailAndPassword(
      {required String email,
      required String password,
      required String username}) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    credential.user!.updateDisplayName(username);
    return credential;
  }

  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> addUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add(
      {
        'id': FirebaseAuth.instance.currentUser!.uid,
        'first name': FirebaseAuth.instance.currentUser!.displayName,
      },
    );
  }
}
