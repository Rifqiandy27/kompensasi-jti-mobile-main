import 'package:flutter/material.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';

class ButtonComponent extends StatelessWidget {
  final String label;
  final Future<void> Function()? onPressed;
  final Color? color;

  const ButtonComponent(
      {super.key,
      required this.label,
      required this.onPressed,
      this.color = MyColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: MyTypography.button.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
