import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgCreateAccount,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 58.v),
                      Text(
                        "Bem vindo de volta!",
                        style: theme.textTheme.displaySmall,
                      ),
                      SizedBox(height: 27.v),
                      CustomImageView(
                        imagePath: ImageConstant.imgTheLittleThings,
                        height: 180.v,
                        width: 414.h,
                      ),
                      SizedBox(height: 32.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.h),
                        child: CustomFloatingTextField(
                          controller: emailController,
                          labelText: "EMAIL",
                          labelStyle: CustomTextStyles.titleSmallCyan300_1,
                          hintText: "DIGITE UM EMAIL",
                          textInputType: TextInputType.emailAddress,
                          borderDecoration:
                              FloatingTextFormFieldStyleHelper.outline,
                        ),
                      ),
                      SizedBox(height: 37.v),
                      _buildPassword(context),
                      SizedBox(height: 9.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 34.h),
                          child: Text(
                            "Esqueceu senha?",
                            style: CustomTextStyles.bodyMediumGray80014,
                          ),
                        ),
                      ),
                      SizedBox(height: 22.v),
                      CustomElevatedButton(
                        text: "Entrar",
                        margin: EdgeInsets.only(
                          left: 23.h,
                          right: 33.h,
                        ),
                        buttonStyle: CustomButtonStyles.none,
                        buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                      ),
                      SizedBox(height: 24.v),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Não tem conta? ",
                              style: CustomTextStyles.bodyMediumGray800,
                            ),
                            TextSpan(
                              text: "Cadastro",
                              style: CustomTextStyles.titleSmallCyan300,
                            )
                          ],
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: CustomFloatingTextField(
        controller: passwordController,
        labelText: "SENHA",
        labelStyle: CustomTextStyles.titleSmallCyan300_1,
        hintText: "DIGITE UMA SENHA",
        textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
        suffix: Container(
          margin: EdgeInsets.symmetric(horizontal: 14.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgEyeIndigo400,
            height: 19.v,
            width: 22.h,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 64.v,
        ),
        borderDecoration: FloatingTextFormFieldStyleHelper.outline,
      ),
    );
  }
}
