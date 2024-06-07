import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.white.withOpacity(0.4),
            thickness: 1,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(text),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Divider(
            color: Colors.white.withOpacity(0.4),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
