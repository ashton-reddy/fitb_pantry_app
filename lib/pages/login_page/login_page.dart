import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fitb_pantry_app/pages/login_page/login_page_store.dart';
import 'package:fitb_pantry_app/pages/login_page/widgets/logo_header_widget.dart';
import 'package:fitb_pantry_app/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginPageStore pageStore = LoginPageStore();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  dynamic selectedSchool;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    pageStore.loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Observer(builder: (context) {
        if (pageStore.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LogoHeaderWidget(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Personal Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40.sp,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          hintText: 'Phone Number',
                          fillColor: const Color(0xfff2f4fa),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          hintText: 'Email',
                          fillColor: const Color(0xfff2f4fa),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          hintText: 'First Name',
                          fillColor: const Color(0xfff2f4fa),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          hintText: 'Last Name',
                          fillColor: const Color(0xfff2f4fa),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      DropdownButtonFormField(
                        items: pageStore.schoolsList,
                        onChanged: (schoolValue) {
                          setState(() {
                            selectedSchool = schoolValue;
                            schoolController.text = schoolValue;
                          });
                        },
                        value: selectedSchool,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          hintText: 'Select a school',
                          fillColor: const Color(0xfff2f4fa),
                          filled: true,
                        ),
                        isExpanded: false,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            bool canStudentOrder = await pageStore
                                .canStudentOrder(emailController.text);
                            if (canStudentOrder) {
                              bool isValidOrderDay =
                                  await pageStore.isTodayValidOrderDay(
                                selectedSchool,
                                phoneController.text,
                                emailController.text,
                                firstNameController.text,
                                lastNameController.text,
                                schoolController.text,
                              );
                              if (isValidOrderDay) {
                                if (context.mounted) {
                                  context.router.replace(
                                    OrderRoute(),
                                  );
                                }
                              } else {
                                const snackBar = SnackBar(
                                  content: Text(
                                    'Sorry, you cannot order from your school at this time',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            } else {
                              const snackBar = SnackBar(
                                content: Text(
                                  'You already ordered this week',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffFF6600),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Center(
                            child: Text(
                              'Start Order',
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
              ],
            ),
          ),
        );
      }),
    );
  }
}
