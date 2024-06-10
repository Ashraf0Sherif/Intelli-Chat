import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellichat/core/di/dependency_injection.dart' as di;
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:intellichat/features/chat/presentation/logic/chat_cubit/chat_cubit.dart';
import 'package:intellichat/features/chat/repos/chat_repo_implementation.dart';
import 'package:intellichat/firebase_options.dart';
import 'package:intellichat/simple_bloc_observer.dart';

import 'constants.dart';
import 'core/di/dependency_injection.dart';
import 'features/auth/repos/auth_repo_implementation.dart';
import 'features/splash/presentation/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.initGetIt();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) => LoginCubit(getIt.get<AuthRepoImplementation>())),
      BlocProvider(
          create: (context) => ChatCubit(getIt.get<ChatRepoImplementation>())),
    ],
    child: const IntelliChat(),
  ));
}

class IntelliChat extends StatelessWidget {
  const IntelliChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimaryColor,
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
