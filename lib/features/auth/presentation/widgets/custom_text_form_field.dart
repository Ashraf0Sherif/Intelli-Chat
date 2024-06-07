import 'package:flutter/material.dart';
import 'package:intellichat/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String)? onChanged;
  final String label;
  final String? hintText;
  final bool? obScureText;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final String? initialValue;
  final Widget? icon;
  final TextEditingController controller;
  final FocusNode? myFocusNode;
  final bool? hideLabel;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.onChanged,
    this.textInputType,
    this.obScureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.validator,
    this.onSaved,
    this.initialValue = "",
    this.icon,
    required this.controller,
    this.hintText,
    this.myFocusNode,
    this.hideLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Field is required";
        }
        return null;
      },

      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      focusNode: myFocusNode,
      keyboardType: textInputType,
      obscureText: obScureText!,
      onChanged: onChanged,
      cursorColor: kSecondaryColor2,
      decoration: InputDecoration(
        floatingLabelBehavior:
            hideLabel == true ? FloatingLabelBehavior.never : null,
        suffixIcon: icon ?? const SizedBox(),
        filled: true,
        fillColor: kSecondaryColor.withOpacity(0.3),
        contentPadding: const EdgeInsets.all(15),
        hintText: hintText,
        labelText: label,
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        border: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color, width: 1.3),
    );
  }
}
