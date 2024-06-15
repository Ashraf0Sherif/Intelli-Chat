import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellichat/core/firebase/firebase_result.dart';
import 'package:intellichat/features/auth/data/models/user_model/user.dart'
    as UserModel;

abstract class AuthRepo {
  Future<FirebaseResult<UserCredential>> loginUsingEmailAndPassword(
      {required String email, required String password});

  Future<FirebaseResult<UserCredential>> loginUsingGoogle();

  Future<FirebaseResult<UserModel.User>> fetchUser(
      {required User firebaseUser});

  Future<FirebaseResult<String>> changeUserAvatar(
      {required User firebaseUser,required File image});

  Future<FirebaseResult<UserCredential>> signupUsingEmailAndPassword(
      {required String email,
      required String password,
      required String username});

  Future<void> resetPassword({required String email});
}
