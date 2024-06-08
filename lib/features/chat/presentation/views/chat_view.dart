import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transitions;
import 'package:intellichat/features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/drawer_body.dart';

import '../../../../constants.dart';
import '../../../../core/router/app_router.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: painting.LinearGradient(
          colors: [kPrimaryColor, kSecondaryColor],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: const Drawer(
            child: DrawerBody(),
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Intelli-Chat"),
            actions: [
              if (FirebaseAuth.instance.currentUser == null)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kSecondaryColor2),
                    child: InkWell(
                        onTap: () {
                          AppRouter.pushNavigation(
                              view: AppRouter.kLoginView,
                              milliseconds: 240,
                              transition: get_transitions
                                  .Transition.leftToRightWithFade);
                        },
                        child: const Text("Login")),
                  ),
                ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          body: const ChatViewBody()),
    );
  }
}
