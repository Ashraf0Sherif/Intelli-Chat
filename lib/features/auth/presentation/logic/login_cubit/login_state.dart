part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginChangeTopicID extends LoginState {}

class LoginFetchUserLoading extends LoginState {}

class LoginFetchUserFailure extends LoginState {
  final String errorMessage;

  LoginFetchUserFailure({required this.errorMessage});
}

class LoginFetchUserSuccess extends LoginState {}

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

class LoginLogoutSuccess extends LoginState {}
