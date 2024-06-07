import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  const CustomPasswordTextFormField({super.key, required this.label});

  final String label;

  @override
  State<CustomPasswordTextFormField> createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState extends State<CustomPasswordTextFormField> {
  bool isSecure = true;
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: passwordController,
      label: widget.label,
      hintText: "●●●●●●●●●●",
      icon: isSecure == true
          ? GestureDetector(
              onTap: () {
                setState(() {
                  isSecure = false;
                });
              },
              child: const Icon(Icons.visibility_off),
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  isSecure = true;
                });
              },
              child: const Icon(Icons.visibility),
            ),
      obScureText: isSecure,
      onChanged: (text) {},
    );
  }
}
