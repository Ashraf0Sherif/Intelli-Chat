import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellichat/core/firebase/custom_firebase.dart';

import 'package:intellichat/core/firebase/firebase_result.dart';
import '../../../core/firebase/firebase_exceptions.dart';
import 'auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final CustomFirebase customFirebase;

  AuthRepoImplementation(this.customFirebase);

  @override
  Future<FirebaseResult<UserCredential>> loginUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var response =
          await customFirebase.loginUser(email: email, password: password);
      return FirebaseResult.success(response);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<UserCredential>> signupUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var response =
          await customFirebase.createUser(email: email, password: password);
      return FirebaseResult.success(response);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<dynamic>> resetPassword({required String email}) async {
    try {
      await customFirebase.resetPassword(email: email);
      return const FirebaseResult.success(null);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }
}
