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
                height: 80.h,
                width: 400.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
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
