import 'package:flutter/material.dart';
import 'package:intellichat/features/home/presentation/widgets/send_message_widget.dart';

import 'not_logged_in.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Expanded(child: NotLoggedIn()),
              SizedBox(height: 20), // Replaces Spacer for spacing
              SendMessageWidget(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
