import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants.dart';

class CustomSpinkKit extends StatelessWidget {
  const CustomSpinkKit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitCubeGrid(
        size: 70,
        color: kSecondaryColor2,
      ),
    );
  }
}
