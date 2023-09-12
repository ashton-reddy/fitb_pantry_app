import 'package:fitb_pantry_app/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoHeaderWidget extends StatelessWidget {
  const LogoHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          imgLogo,
          width: 108.w,
          height: 45.h,
        ),
        const SizedBox(),
      ],
    );
  }
}
