import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import 'widgets/userprofile_item_widget.dart'; // ignore_for_file: must_be_immutable

class HomepagePage extends StatelessWidget {
  const HomepagePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              _buildStackboatarde(context),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 31.v,
                ),
                child: Column(
                  children: [
                    _buildRowhistricode(context),
                    SizedBox(height: 16.v),
                    _buildUserprofile(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackboatarde(BuildContext context) {
    return SizedBox(
      height: 322.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 41.v),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: fs.Svg(
                    ImageConstant.imgGroup8,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: CustomAppBar(
                title: Padding(
                  padding: EdgeInsets.only(left: 24.h),
                  child: Column(
                    children: [
                      AppbarSubtitle(
                        text: "Boa tarde,",
                        margin: EdgeInsets.only(right: 98.h),
                      ),
                      SizedBox(height: 6.v),
                      AppbarTitle(
                        text: "Enjelin Morgeana",
                      )
                    ],
                  ),
                ),
                actions: [
                  AppbarTrailingIconbutton(
                    imagePath: ImageConstant.imgBell1,
                    margin: EdgeInsets.fromLTRB(24.h, 2.v, 24.h, 5.v),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 25.v,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImageConstant.imgGroup14,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Balanço Total",
                            style:
                                CustomTextStyles.titleMediumWhiteA700SemiBold,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgArrowDown,
                            height: 18.adaptSize,
                            width: 18.adaptSize,
                            margin: EdgeInsets.only(
                              left: 2.h,
                              bottom: 2.v,
                            ),
                          )
                        ],
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup8Gray200,
                        height: 5.v,
                        width: 21.h,
                        margin: EdgeInsets.only(
                          top: 10.v,
                          bottom: 5.v,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    " 1,556.00",
                    style: theme.textTheme.headlineLarge,
                  ),
                  SizedBox(height: 36.v),
                  Padding(
                    padding: EdgeInsets.only(right: 11.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 3.v,
                            bottom: 8.v,
                          ),
                          child: CustomIconButton(
                            height: 36.adaptSize,
                            width: 36.adaptSize,
                            padding: EdgeInsets.all(9.h),
                            decoration: IconButtonStyleHelper.fillWhiteATL18,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgLightBulb,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.h,
                            bottom: 2.v,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Renda",
                                style: CustomTextStyles.titleMediumBluegray100,
                              ),
                              Text(
                                " 1,840.00",
                                style: theme.textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.v,
                            bottom: 6.v,
                          ),
                          child: CustomIconButton(
                            height: 36.adaptSize,
                            width: 36.adaptSize,
                            padding: EdgeInsets.all(9.h),
                            decoration: IconButtonStyleHelper.fillWhiteATL18,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgArrowRight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.h,
                            top: 4.v,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Despesas",
                                style: CustomTextStyles.titleMediumBluegray100,
                              ),
                              Text(
                                " 284.00",
                                style: theme.textTheme.titleLarge,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 2.v)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowhistricode(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Histórico de transações",
            style: CustomTextStyles.titleMediumGray900,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.v),
            child: Text(
              "Ver tudo",
              style: CustomTextStyles.bodyMediumGray700,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserprofile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 16.v,
          );
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return UserprofileItemWidget();
        },
      ),
    );
  }
}
