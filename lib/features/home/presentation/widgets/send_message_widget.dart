import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants.dart';
import '../../../auth/presentation/widgets/custom_text_form_field.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({
    super.key,
  });

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            label: 'Ask me anything',
            hintText: "Ask me anything",
            onChanged: (text) {},
            controller: _messageController,
            hideLabel: true,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kSecondaryColor,
          ),
          child: InkWell(
            onTap: () {},
            child: const Icon(
              FontAwesomeIcons.paperPlane,
              color: kSecondaryColor2,
            ),
          ),
        ),
      ],
    );
  }
}
