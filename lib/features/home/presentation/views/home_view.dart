import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:intellichat/constants.dart';
import 'package:intellichat/features/auth/presentation/views/login_view.dart';
import 'package:intellichat/features/home/presentation/widgets/home_view_body.dart';

import '../widgets/drawer_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kSecondaryColor2),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginView();
                          },
                        ),
                      );
                    },
                    child: const Text("Login")),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: const HomeViewBody(),
      ),
    );
  }
}
