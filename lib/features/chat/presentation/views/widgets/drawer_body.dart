import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intellichat/core/router/app_router.dart';
import 'package:intellichat/core/utils/styles.dart';

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
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        userName = FirebaseAuth.instance.currentUser!.email!;
      } else {
        userName = FirebaseAuth.instance.currentUser!.displayName!;
      }
    }
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
                height: 30,
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
                      userName,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.kTextStyle16,
                    ),
                  ),
                  if (FirebaseAuth.instance.currentUser != null)
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        GoogleSignIn().signOut();
                        AppRouter.pushReplacementAll(
                            view: AppRouter.kChatView,
                            milliseconds: 1200,
                            transition: Transition.fadeIn);
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
          ),
        ),
      ),
    );
  }
}
