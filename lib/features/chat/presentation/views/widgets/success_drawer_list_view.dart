import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/widgets/my_behavior.dart';
import '../../../../auth/presentation/logic/login_cubit/login_cubit.dart';
import '../../../../auth/presentation/views/widgets/custom_text_form_field.dart';
import 'custom_dialog.dart';
import 'custom_topics_list_view.dart';

class SuccessDrawerListView extends StatefulWidget {
  const SuccessDrawerListView({super.key});

  @override
  State<SuccessDrawerListView> createState() => _SuccessDrawerListViewState();
}

class _SuccessDrawerListViewState extends State<SuccessDrawerListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomTextFormField(
            label: 'Search chat history',
            onChanged: (text) {
              BlocProvider.of<LoginCubit>(context).searchTopic(text);
            },
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
                      return const CustomCreateAlertDialog();
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
          const CustomTopicsListView(),
        ],
      ),
    );
  }
}
