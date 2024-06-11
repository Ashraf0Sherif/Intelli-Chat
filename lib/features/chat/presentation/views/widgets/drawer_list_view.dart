import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intellichat/constants.dart';
import 'package:intellichat/core/utils/widgets/my_behavior.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:intellichat/features/chat/presentation/logic/chat_cubit/chat_cubit.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../auth/presentation/views/widgets/custom_text_form_field.dart';
import '../../../repos/chat_repo_implementation.dart';
import 'custom_dialog.dart';
import 'custom_topics_list_view.dart';

class DrawerListView extends StatefulWidget {
  const DrawerListView({super.key});

  @override
  State<DrawerListView> createState() => _DrawerListViewState();
}

class _DrawerListViewState extends State<DrawerListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginFetchUserLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else {
          return ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  CustomTextFormField(
                    label: 'Search chat history',
                    onChanged: (text) {},
                    controller: _searchController,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Recent Chats"),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => ChatCubit(
                                    getIt.get<ChatRepoImplementation>()),
                                child: const CustomCreateAlertDialog(),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          FontAwesomeIcons.message,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocProvider(
                    create: (context) =>
                        ChatCubit(getIt.get<ChatRepoImplementation>()),
                    child: CustomTopicsListView(
                        topics:
                            BlocProvider.of<LoginCubit>(context).user!.topics!),
                  ),
                ],
              ));
        }
      },
    );
  }
}
