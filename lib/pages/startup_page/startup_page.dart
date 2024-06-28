import 'package:auto_route/auto_route.dart';
import 'package:fitb_pantry_app/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class StartupPage extends StatelessWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 300.0), // Adjust the top padding as needed
                child: Image.asset(
                  'assets/fitb.png',
                  width: 300,
                ),
              ),
              Spacer(), // Pushes the button to the bottom
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 360.0), // Adjust the bottom padding as needed
                child: Builder(
                  builder: (BuildContext newContext) {
                    return ElevatedButton(
                        onPressed: () {
                          context.router.push(const LoginRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFF6600),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0), // Adjust padding as needed
                          minimumSize: const Size(
                              200.0, 50.0), // Set minimum button size
                          textStyle: const TextStyle(
                              fontSize: 20.0), // Adjust text size
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
