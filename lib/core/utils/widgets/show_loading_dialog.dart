import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../assets_data.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const Center(
        child: SizedBox(
          height: 180,
          child: RiveAnimation.asset(
            AssetsData.kRiveLoading,
          ),
        ),
      );
    },
  );
}
