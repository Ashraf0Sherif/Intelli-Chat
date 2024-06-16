import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellichat/constants.dart';
import 'package:meta/meta.dart';

import '../../../../../core/firebase/firebase_exceptions.dart';
import '../../../../../core/media/media_seervice.dart';
import '../../../../auth/repos/auth_repo_implementation.dart';

part 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  final AuthRepoImplementation authRepoImplementation;

  AvatarCubit(this.authRepoImplementation) : super(AvatarInitial());

  Future<void> changeUserAvatar(
      {required User firebaseUser, required bool isConnectedToInternet}) async {
    File? image = await MediaService().getImageFromGallery();
    if (image != null) {
      emit(AvatarChangeLoading());
      if (!isConnectedToInternet) {
        emit(AvatarChangeFailure(errorMessage: kNoInternetMessage));
      } else {
        var response = await authRepoImplementation.changeUserAvatar(
            firebaseUser: firebaseUser, image: image);
        response.when(
          success: (downloadUrl) {
            emit(AvatarChangeSuccess(avatarUrl: downloadUrl));
          },
          failure: (FirebaseExceptions firebaseExceptions) {
            emit(
              AvatarChangeFailure(
                errorMessage:
                    FirebaseExceptions.getErrorMessage(firebaseExceptions),
              ),
            );
          },
        );
      }
    }
  }
}
