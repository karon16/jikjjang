import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';
import 'package:jikjjang_app/utils/constants/sizes.dart';

class Sectionheader extends StatelessWidget {
  const Sectionheader(
      {super.key,
      required this.sectionTextButton,
      required this.sectionHeader,
      required this.callback});

  final String sectionHeader;
  final String sectionTextButton;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(sectionHeader,
              style: const TextStyle(
                  fontSize: JSizes.font16,
                  fontWeight: FontWeight.bold,
                  color: JAppColors.textPrimary)),
        ),
        TextButton(
          onPressed: callback,
          child: Text(
            sectionTextButton,
            style: const TextStyle(
                color: JAppColors.primary, fontSize: JSizes.font14),
          ),
        )
      ],
    );
  }
}
