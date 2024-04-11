import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 42.v),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      ImageConstant.imgGroup4,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 38.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgBrazucaBrowsing,
                      height: 477.v,
                      width: 414.h,
                    )
                  ],
                ),
              ),
              SizedBox(height: 28.v),
              SizedBox(
                width: 271.h,
                child: Text(
                  "gaste de forma mais inteligente",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall!.copyWith(
                    height: 1.06,
                  ),
                ),
              ),
              SizedBox(height: 13.v),
              CustomElevatedButton(
                height: 73.v,
                width: 72.h,
                text: "->",
                buttonStyle: CustomButtonStyles.none,
                decoration: CustomButtonStyles.gradientCyanToBlueDecoration,
                buttonTextStyle: theme.textTheme.displayMedium!,
              ),
              SizedBox(height: 24.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Já tem conta? ",
                      style: CustomTextStyles.bodyMediumGray800,
                    ),
                    TextSpan(
                      text: "Entrar",
                      style: CustomTextStyles.titleSmallCyan300,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }
}
