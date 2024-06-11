import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/drawer_body.dart';

import '../../../../constants.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    BlocProvider.of<LoginCubit>(context)
        .fetchUser(firebaseUser: FirebaseAuth.instance.currentUser!);
    super.initState();
  }

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
        ),
        body: const ChatViewBody(),
      ),
    );
  }
}
