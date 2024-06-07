part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginResetPasswordLoading extends LoginState {}

class LoginResetPasswordSuccess extends LoginState {}

class LoginResetPasswordFailure extends LoginState {
  final String errorMessage;

  LoginResetPasswordFailure({required this.errorMessage});
}

class LoginSuccess extends LoginState {
  final UserCredential credential;

  LoginSuccess({required this.credential});
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
