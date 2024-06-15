import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellichat/core/firebase/custom_firebase.dart';
import 'package:intellichat/core/firebase/firebase_result.dart';
import 'package:intellichat/features/auth/data/models/user_model/user.dart'
    as UserModel;

import '../../../core/firebase/firebase_exceptions.dart';
import '../../../core/media/media_seervice.dart';
import 'auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final CustomFirebase customFirebase;
  final MediaService mediaService;

  AuthRepoImplementation(this.customFirebase, this.mediaService);

  @override
  Future<FirebaseResult<UserCredential>> loginUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var response = await customFirebase.loginUsingEmailAndPassword(
          email: email, password: password);
      return FirebaseResult.success(response);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<UserCredential>> loginUsingGoogle() async {
    try {
      var user = await customFirebase.loginUsingGoogle();
      return FirebaseResult.success(user);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<UserCredential>> signupUsingEmailAndPassword(
      {required String email,
      required String password,
      required String username}) async {
    try {
      var response = await customFirebase.signupUsingEmailAndPassword(
          email: email, password: password, username: username);
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

  @override
  Future<FirebaseResult<UserModel.User>> fetchUser(
      {required User firebaseUser}) async {
    try {
      var user = await customFirebase.fetchUserDate(firebaseUser);
      return FirebaseResult.success(user);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<String>> changeUserAvatar(
      {required User firebaseUser, required File image}) async {
    try {
      var downloadUrl = await customFirebase.changeUserAvatar(
          firebaseUser: firebaseUser, image: image);
      return FirebaseResult.success(downloadUrl);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }
}
