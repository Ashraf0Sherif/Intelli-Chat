import 'package:flutter/material.dart';
import 'package:intellichat/constants.dart';

void showSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all( Radius.circular(4)),
        side: BorderSide(color: kSecondaryColor),
      ),
      backgroundColor: kSecondaryColor2,
      content: Text(
        message,
        //style: const TextStyle(fontSize: 16),
      ),
    ),
  );
}
