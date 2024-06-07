import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class LoginMethod extends StatelessWidget {
  const LoginMethod({
    super.key,
    this.icon,
    required this.text,
    this.onTap,
  });

  final IconData? icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 100,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? Icon(icon) : const SizedBox(),
              SizedBox(
                width: icon == null ? 0 : 20,
              ),
              Text(
                text,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
