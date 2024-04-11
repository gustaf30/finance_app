import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController irvanmosesController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController abcdController = TextEditingController();

  TextEditingController confirmesuaController = TextEditingController();

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
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 46.v),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStackcomecea(context),
                    SizedBox(height: 32.v),
                    _buildIrvanmoses(context),
                    SizedBox(height: 24.v),
                    _buildEmail(context),
                    SizedBox(height: 24.v),
                    _buildAbcd1(context),
                    SizedBox(height: 5.v),
                    _buildColumndeveterpe(context),
                    SizedBox(height: 38.v),
                    _buildCadastrar(context),
                    SizedBox(height: 16.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Já tem conta? ",
                            style: CustomTextStyles.bodyMediumGray800,
                          ),
                          TextSpan(
                            text: "Entrar",
                            style: CustomTextStyles.bodyMediumCyan300,
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
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackcomecea(BuildContext context) {
    return SizedBox(
      height: 291.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 259.h,
              child: Text(
                "Comece a economizar O teu dinheiro!",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall!.copyWith(
                  height: 1.06,
                ),
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgStuckAtHomeTo,
            height: 180.v,
            width: 414.h,
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildIrvanmoses(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 22.h,
        right: 28.h,
      ),
      child: CustomFloatingTextField(
        controller: irvanmosesController,
        labelText: "NOME",
        labelStyle: theme.textTheme.titleSmall!,
        hintText: "NOME",
        hintStyle: theme.textTheme.titleSmall!,
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 22.h,
        right: 28.h,
      ),
      child: CustomFloatingTextField(
        controller: emailController,
        labelText: "EMAIL",
        labelStyle: theme.textTheme.titleSmall!,
        hintText: "EMAIL",
        hintStyle: theme.textTheme.titleSmall!,
        textInputType: TextInputType.emailAddress,
      ),
    );
  }

  /// Section Widget
  Widget _buildAbcd1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 22.h,
        right: 28.h,
      ),
      child: CustomFloatingTextField(
        controller: abcdController,
        labelText: "ESCOLHA SUA SENHA",
        labelStyle: theme.textTheme.titleSmall!,
        hintText: "ESCOLHA SUA SENHA",
        hintStyle: theme.textTheme.titleSmall!,
        textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
        suffix: Container(
          margin: EdgeInsets.symmetric(horizontal: 14.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgEye,
            height: 19.v,
            width: 22.h,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 64.v,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumndeveterpe(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deve ter pelo menos 8 caracteres",
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.only(right: 6.h),
            child: CustomFloatingTextField(
              controller: confirmesuaController,
              labelText: "CONFIRME SUA SENHA",
              labelStyle: theme.textTheme.titleSmall!,
              hintText: "CONFIRME SUA SENHA",
              hintStyle: theme.textTheme.titleSmall!,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
              suffix: Container(
                margin: EdgeInsets.symmetric(horizontal: 14.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgEyeBlue600,
                  height: 15.v,
                  width: 22.h,
                ),
              ),
              suffixConstraints: BoxConstraints(
                maxHeight: 64.v,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.h, 15.v, 20.h, 19.v),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCadastrar(BuildContext context) {
    return CustomElevatedButton(
      text: "cadastrar",
      margin: EdgeInsets.only(
        left: 22.h,
        right: 34.h,
      ),
      buttonStyle: CustomButtonStyles.none,
      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
    );
  }
}
