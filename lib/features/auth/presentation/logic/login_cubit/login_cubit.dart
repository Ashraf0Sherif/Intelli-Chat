import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../core/firebase/firebase_exceptions.dart';
import '../../../repos/auth_repo_implementation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepoImplementation authRepoImplementation;

  LoginCubit(this.authRepoImplementation) : super(LoginInitial());

  Future<void> loginUsingEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoading());
    var response = await authRepoImplementation.loginUsingEmailAndPassword(
        email: email, password: password);
    response.when(
      success: (credential) {
        emit(LoginSuccess(credential: credential));
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
}
