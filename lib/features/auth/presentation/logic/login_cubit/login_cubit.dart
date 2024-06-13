import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intellichat/features/auth/models/user_model/user.dart'
    as UserModel;
import 'package:meta/meta.dart';

import '../../../../../core/firebase/firebase_exceptions.dart';
import '../../../../chat/presentation/data/models/topic_model/topic.dart';
import '../../../repos/auth_repo_implementation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepoImplementation authRepoImplementation;
  UserModel.User? user;
  bool networkConnection = true;
  List<Topic> userTopics = [];

  LoginCubit(this.authRepoImplementation) : super(LoginInitial());

  Future<void> loginUsingEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoading());
    var response = await authRepoImplementation.loginUsingEmailAndPassword(
        email: email, password: password);
    response.when(
      success: (user) async {
        emit(LoginSuccess());
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(
          LoginFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions),
          ),
        );
      },
    );
  }

  Future<void> loginUsingGoogle() async {
    emit(LoginLoading());
    var response = await authRepoImplementation.loginUsingGoogle();
    response.when(
      success: (user) {
        emit(LoginSuccess());
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(
          LoginFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions),
          ),
        );
      },
    );
  }

  Future<void> fetchUser({required User firebaseUser}) async {
    emit(LoginFetchUserLoading());
    var response =
        await authRepoImplementation.fetchUser(firebaseUser: firebaseUser);
    response.when(
      success: (user) {
        this.user = user;
        userTopics = user.topics!;
        emit(LoginFetchUserSuccess());
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(
          LoginFetchUserFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions),
          ),
        );
      },
    );
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      emit(LoginInitial());
    } catch (error) {
      emit(LoginLogoutFailure());
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(LoginResetPasswordLoading());
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () async {
        var response = await authRepoImplementation.resetPassword(email: email);
        response.when(
          success: (credential) {
            emit(LoginResetPasswordSuccess());
          },
          failure: (FirebaseExceptions firebaseExceptions) {
            emit(
              LoginFailure(
                errorMessage:
                    FirebaseExceptions.getErrorMessage(firebaseExceptions),
              ),
            );
          },
        );
      },
    );
  }

  void searchTopic(String searchText) {
    if (searchText.isEmpty) {
      user!.topics = userTopics;
    } else {
      user!.topics = user!.topics!
          .where((element) =>
              element.title!.toLowerCase().startsWith(searchText.toLowerCase()))
          .toList();
    }
    emit(LoginFetchUserSuccess());
  }
}
