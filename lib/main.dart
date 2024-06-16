import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellichat/core/di/dependency_injection.dart' as di;
import 'package:intellichat/core/utils/assets_data.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:intellichat/features/auth/presentation/views/login_view.dart';
import 'package:intellichat/features/chat/presentation/logic/chat_cubit/chat_cubit.dart';
import 'package:intellichat/features/chat/presentation/views/chat_view.dart';
import 'package:intellichat/features/chat/repos/chat_repo_implementation.dart';
import 'package:intellichat/firebase_options.dart';
import 'package:intellichat/simple_bloc_observer.dart';
import 'package:splash_view/source/presentation/pages/pages.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

import 'constants.dart';
import 'core/di/dependency_injection.dart';
import 'features/auth/repos/auth_repo_implementation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.initGetIt();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                LoginCubit(getIt.get<AuthRepoImplementation>())),
        BlocProvider(
            create: (context) =>
                ChatCubit(getIt.get<ChatRepoImplementation>())),
      ],
      child: const IntelliChat(),
    ),
  );
}

class IntelliChat extends StatefulWidget {
  const IntelliChat({super.key});

  @override
  State<IntelliChat> createState() => _IntelliChatState();
}

class _IntelliChatState extends State<IntelliChat> {
  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        BlocProvider.of<LoginCubit>(context).networkConnection =
            result != ConnectivityResult.none;
      },
    );
  }

  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    BlocProvider.of<LoginCubit>(context).networkConnection =
        connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimaryColor,
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashView(
        backgroundColor: const Color(0xff0A1234),
        logo: Center(
          child: Image.asset(AssetsData.kLogo,width: MediaQuery.of(context).size.width*0.67,),
        ),
        done: Done(FirebaseAuth.instance.currentUser == null
            ? const LoginView()
            : const ChatView(),animationDuration: const Duration(seconds: 0)),
      ),
    );
  }
}
