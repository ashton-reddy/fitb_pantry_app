import 'package:auto_route/auto_route.dart';
import 'package:fitb_pantry_app/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class StartupPage extends StatelessWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 100.h, 0, 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage('assets/fitb.png'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(const LoginRoute());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                elevation: 0.0,
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 20.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff2F4DED),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
