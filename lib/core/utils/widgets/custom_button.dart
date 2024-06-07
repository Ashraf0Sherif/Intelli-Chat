import 'package:flutter/material.dart';
import 'package:intellichat/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback? onPressed;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kSecondaryColor.withOpacity(0.7),
          shadowColor: Colors.grey,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: kSecondaryColor2,
            ),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
