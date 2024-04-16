import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const PrimaryButton({
    required this.text,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(28)),
          gradient: LinearGradient(
            colors: [
              AppColors.lightBlue1,
              AppColors.lightBlue2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          onTap: onPressed,
          child: Container(
            height: 56,
            alignment: Alignment.center,
            width: 356,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(28)),
              gradient: LinearGradient(
                colors: [
                  AppColors.lightBlue1,
                  AppColors.lightBlue2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Text(
              text,
              style: 
                AppTextStyles.notSoSmallText.copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}