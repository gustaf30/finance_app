import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, 0.5),
              end: Alignment(1, 0.5),
              colors: [appTheme.cyan300, appTheme.blue900.withOpacity(0.96)],
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 251.v),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgBlackGreyMini,
                  height: 225.v,
                  width: 240.h,
                ),
                SizedBox(height: 5.v),
                Text(
                  "BUGDY",
                  style: CustomTextStyles.displayMediumArchivoBlackBlue900,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
