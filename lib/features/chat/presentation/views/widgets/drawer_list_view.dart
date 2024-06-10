import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/core/utils/widgets/my_behavior.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import '../../../../auth/presentation/views/widgets/custom_text_form_field.dart';

class DrawerListView extends StatefulWidget {
  const DrawerListView({super.key});

  @override
  State<DrawerListView> createState() => _DrawerListViewState();
}

class _DrawerListViewState extends State<DrawerListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                CustomTextFormField(
                  label: 'Search chat history',
                  onChanged: (text) {},
                  controller: _searchController,
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Recent Chats"),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: state.user.topics!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        state.user.topics![index].title!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Login"));
          }
        },
      ),
    );
  }
}
