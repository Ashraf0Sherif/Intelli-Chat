import 'package:flutter/material.dart';
import 'package:intellichat/core/utils/styles.dart';
import 'package:intellichat/core/utils/widgets/my_behavior.dart';

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
      child: ListView(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo_pic.png',
                height: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Intelli-Chat")
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              label: 'Search chat history',
              onChanged: (text) {},
              controller: _searchController),
          const SizedBox(
            height: 10,
          ),
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
              Text(
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
              Text("Web page", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 10,
              ),
              Text("Web page", style: TextStyle(fontWeight: FontWeight.w600)),
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
              Text("Web page", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10,
              ),
              Text("Web page", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10,
              ),
              Text("Web page", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20, // Replace Spacer with SizedBox for spacing
          ),
        ],
      ),
    );
  }
}
