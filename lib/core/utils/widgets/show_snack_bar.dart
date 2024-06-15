import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellichat/constants.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
}) {
  Get.showSnackbar(GetSnackBar(
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.TOP,
    messageText: Text(message),
    margin: const EdgeInsets.all(10),
    backgroundColor: backgroundColor ?? Colors.red.shade400,
    borderRadius: 12,
    borderColor: kSecondaryColor,
  ));
}
