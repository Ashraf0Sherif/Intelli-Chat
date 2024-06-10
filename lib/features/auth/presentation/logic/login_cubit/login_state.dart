part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

class LoginResetPasswordLoading extends LoginState {}

class LoginResetPasswordSuccess extends LoginState {}

class LoginResetPasswordFailure extends LoginState {
  final String errorMessage;

  LoginResetPasswordFailure({required this.errorMessage});
}

class LoginLogoutLoading extends LoginState {}

class LoginLogoutFailure extends LoginState {}
