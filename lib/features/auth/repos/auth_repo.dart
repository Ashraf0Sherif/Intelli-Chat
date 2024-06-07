import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellichat/core/firebase/firebase_result.dart';

abstract class AuthRepo {
  Future<FirebaseResult<UserCredential>> loginUsingEmailAndPassword(
      {required String email, required String password});

  Future<FirebaseResult<UserCredential>> signupUsingEmailAndPassword(
      {required String email, required String password});
}
