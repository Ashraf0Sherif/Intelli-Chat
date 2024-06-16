import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intellichat/core/utils/styles.dart';
import 'package:intellichat/core/utils/widgets/custom_spinkit.dart';
import 'package:intellichat/core/utils/widgets/show_snack_bar.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:intellichat/features/chat/presentation/logic/avatar_cubit/avatar_cubit.dart';

import '../../../../../constants.dart';
import 'drawer_list_view.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({super.key});

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  @override
  void initState() {
    BlocProvider.of<LoginCubit>(context).searchTopic('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginFetchUserSuccess ||
                  state is LoginChangeTopicID) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo_pic.png',
                          height: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Intelli-Chat")
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Expanded(child: DrawerListView()),
                    Row(
                      children: [
                        const CustomUserAvatar(),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            BlocProvider.of<LoginCubit>(context)
                                .user!
                                .displayName!,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.kTextStyle16,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (BlocProvider.of<LoginCubit>(context)
                                .networkConnection) {
                              BlocProvider.of<LoginCubit>(context).signOut();
                            } else {
                              Navigator.of(context).pop();
                              showSnackBar(context,
                                  message: kNoInternetMessage);
                            }
                          },
                          icon: const Icon(
                            FontAwesomeIcons.rightFromBracket,
                            color: Colors.red,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              } else {
                return const CustomSpinkKit();
              }
            },
          ),
        ),
      ),
    );
  }
}

class CustomUserAvatar extends StatefulWidget {
  const CustomUserAvatar({
    super.key,
  });

  @override
  State<CustomUserAvatar> createState() => _CustomUserAvatarState();
}

class _CustomUserAvatarState extends State<CustomUserAvatar> {
  void _changeUserAvatar() {
    BlocProvider.of<AvatarCubit>(context).changeUserAvatar(
        firebaseUser: FirebaseAuth.instance.currentUser!,
        isConnectedToInternet:
            BlocProvider.of<LoginCubit>(context).networkConnection);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvatarCubit, AvatarState>(
      builder: (context, state) {
        if (state is AvatarChangeSuccess) {
          BlocProvider.of<LoginCubit>(context).user!.avatarUrl =
              state.avatarUrl;
        }
        if (state is AvatarChangeLoading) {
          return const SpinKitPulse(
            color: kSecondaryColor2,
            size: 30,
          );
        }
        if (BlocProvider.of<LoginCubit>(context).user!.avatarUrl == null) {
          return InkWell(
            onTap: _changeUserAvatar,
            child: const Icon(
              FontAwesomeIcons.imagePortrait,
              size: 30,
              color: kPrimaryColor,
            ),
          );
        } else {
          return InkWell(
            onTap: _changeUserAvatar,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: CachedNetworkImage(
                width: 30,
                placeholder: (context, text) {
                  return const SpinKitPulse(
                    color: kSecondaryColor2,
                  );
                },
                imageUrl: BlocProvider.of<LoginCubit>(context).user!.avatarUrl!,
              ),
            ),
          );
        }
      },
    );
  }
}
