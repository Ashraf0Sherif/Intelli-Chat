import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/core/utils/styles.dart';
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
          if(state is LoginSuccess){
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                CustomTextFormField(
                    label: 'Search chat history',
                    onChanged: (text) {},
                    controller: _searchController),
                const SizedBox(height: 10,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Recent Chats"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Web page",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Web page",
                        style: Styles.kTextStyle14
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Web page",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Web page",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Last Months"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Web page",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Web page",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Web page",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Web page",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20, // Replace Spacer with SizedBox for spacing
                ),
              ],
            );
          }
          else{
            return Center(child: Text("Login"),);
          }
        },
      ),
    );
  }
}
