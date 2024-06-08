import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../core/firebase/firebase_exceptions.dart';
import '../../../repos/auth_repo_implementation.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepoImplementation authRepoImplementation;

  RegisterCubit(this.authRepoImplementation) : super(RegisterInitial());

  Future<void> signupUsingEmailAndPassword(
      {required String email,
      required String password,
      required String username}) async {
    emit(RegisterLoading());
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () async {
        var response = await authRepoImplementation.signupUsingEmailAndPassword(
            email: email, password: password, username: username);
        response.when(
          success: (credential) {
            emit(RegisterSuccess(credential: credential));
          },
          failure: (FirebaseExceptions firebaseExceptions) {
            emit(
              RegisterFailure(
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
