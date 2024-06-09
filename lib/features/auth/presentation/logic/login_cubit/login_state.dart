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

class LoginUsingGoogleSuccess extends LoginState {}

class LoginUsingGoogleLoading extends LoginState {}

class LoginUsingGoogleFailure extends LoginState {
  final String errorMessage;

  LoginUsingGoogleFailure(this.errorMessage);
}

class LoginSuccess extends LoginState {
  final UserModel.User user;

  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
