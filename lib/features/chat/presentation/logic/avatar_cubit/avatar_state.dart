part of 'avatar_cubit.dart';

@immutable
abstract class AvatarState {}

class AvatarInitial extends AvatarState {}

class AvatarChangeLoading extends AvatarState {}

class AvatarChangeFailure extends AvatarState {
  final String errorMessage;

  AvatarChangeFailure({required this.errorMessage});
}

class AvatarChangeSuccess extends AvatarState {
  final String avatarUrl;
  AvatarChangeSuccess({required this.avatarUrl});
}
