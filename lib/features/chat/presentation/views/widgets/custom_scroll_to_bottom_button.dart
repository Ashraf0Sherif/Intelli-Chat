import 'package:flutter/material.dart';
import 'package:intellichat/constants.dart';
class CustomScrollToBottomButton extends StatelessWidget {
  const CustomScrollToBottomButton({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 25,
              child: FloatingActionButton(
                onPressed: () {
                  scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                backgroundColor: kSecondaryColor,
                child: const Icon(
                  Icons.arrow_downward_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}