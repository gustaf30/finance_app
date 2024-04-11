import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart'; // ignore: must_be_immutable

class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          height: 50.adaptSize,
          width: 50.adaptSize,
          padding: EdgeInsets.all(8.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgFrame9,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 9.h,
            top: 5.v,
            bottom: 3.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upwork",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 5.v),
              Text(
                "Hoje",
                style: CustomTextStyles.bodyMediumGray700_1,
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 7.v,
            bottom: 4.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "+  850.00",
                style: CustomTextStyles.titleMediumGreen600,
              ),
              Padding(
                padding: EdgeInsets.only(right: 4.h),
                child: Text(
                  "feito",
                  style: theme.textTheme.bodyMedium,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
