import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellichat/core/firebase/firebase_result.dart';
import 'package:intellichat/features/auth/models/user_model/user.dart'
    as UserModel;

abstract class AuthRepo {
  Future<FirebaseResult<UserModel.User>> loginUsingEmailAndPassword(
      {required String email, required String password});

  Future<FirebaseResult<UserModel.User>> loginUsingGoogle();

  Future<FirebaseResult<UserModel.User>> fetchUser({required User firebaseUser});

  Future<FirebaseResult<UserCredential>> signupUsingEmailAndPassword(
      {required String email,
      required String password,
      required String username});

  Future<void> resetPassword({required String email});
}
