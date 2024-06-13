import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transitions;
import 'package:intellichat/core/router/app_router.dart';
import 'package:intellichat/core/utils/styles.dart';
import 'package:intellichat/core/utils/widgets/show_snack_bar.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';

import '../../../../../constants.dart';
import 'drawer_list_view.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({super.key});

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  String userName = "guest";

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
          child: Column(
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
                  Image.asset(
                    'assets/images/logo_pic.png',
                    height: 22,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      BlocProvider.of<LoginCubit>(context).user!.displayName!,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.kTextStyle16,
                    ),
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginFetchUserSuccess) {
                        return IconButton(
                          onPressed: () {
                            if (BlocProvider.of<LoginCubit>(context)
                                .networkConnection) {
                              BlocProvider.of<LoginCubit>(context).signOut();
                              AppRouter.pushReplacementAll(
                                  view: AppRouter.kLoginView,
                                  milliseconds: 1200,
                                  transition:
                                      get_transitions.Transition.fadeIn);
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
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
