import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitb_pantry_app/pages/login_page/login_page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginPageStore pageStore = LoginPageStore();

  String globalDocumentId = '';
  int weekdaysValue = DateTime.now().weekday;
  late Timestamp timestamp;
  final DateTime now = DateTime.now();
  final builder1 = ValidationBuilder().phone();
  DateTime? closeDate;
  final builder2 = ValidationBuilder().email();
  final TextInputFormatter digitsOnly =
      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'));
  final _numberForm = GlobalKey<FormState>();
  bool isValidForm = false;
  var selectedSchool1;
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerFirst = TextEditingController();
  final TextEditingController _controllerLast = TextEditingController();
  final TextEditingController _controllerSchool = TextEditingController();

  @override
  void initState() {
    timestamp = Timestamp.fromDate(DateTime(weekdaysValue));
    pageStore.loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          if(pageStore.isLoading){
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(width: double.infinity, height: 100),
              const Image(
                image: AssetImage('assets/fitb.png'),
              ),
              Column(
                children: [
                  Form(
                    key: _numberForm,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _controllerPhone,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 20,
                            ),
                            hintText: 'Phone Number',
                            constraints:
                                const BoxConstraints(maxWidth: 300, minWidth: 300),
                          ),
                          validator: builder1.maxLength(15).build(),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _controllerEmail,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 20,
                            ),
                            hintText: "Email",
                            constraints:
                                const BoxConstraints(maxWidth: 300, minWidth: 300),
                          ),
                          validator: builder2.maxLength(50).build(),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _controllerFirst,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 20,
                            ),
                            hintText: "First Name",
                            constraints:
                                const BoxConstraints(maxWidth: 300, minWidth: 300),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                          ],
                          validator: (String? value) {
                            if (value != null && value.isEmpty) {
                              return "Field can't be empty";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _controllerLast,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 20,
                            ),
                            hintText: "Last Name",
                            constraints:
                                const BoxConstraints(maxWidth: 300, minWidth: 300),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                          ],
                          validator: (String? value) {
                            if (value != null && value.isEmpty) {
                              return "Field can't be empty";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: DropdownButtonFormField(
                                items: pageStore.schoolsList,
                                onChanged: (schoolValue) {
                                  setState(() {
                                    selectedSchool1 = schoolValue;
                                    _controllerSchool.text = schoolValue;
                                  });
                                },
                                value: selectedSchool1,
                                isExpanded: false,
                                hint: Text(
                                  "Select your school",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 20,
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                              ),
                            ),
                            const SizedBox(height: 75),
                            ElevatedButton(
                              onPressed: () async {
                                bool isFormEnabled =
                                await pageStore.isTodayValidOrderDay(selectedSchool1);

                                if (isFormEnabled) {
                                  if (_numberForm.currentState!.validate()) {
                                    setState(() {
                                      isValidForm = true;
                                    });
                                    Map<String, dynamic> dataToSave = {
                                      'phone number': _controllerPhone.text,
                                      'email': _controllerEmail.text,
                                      'first name': _controllerFirst.text,
                                      'last name': _controllerLast.text,
                                      'school': _controllerSchool.text,
                                      'isValidStudent': 0,
                                    };
                                    CollectionReference collectionRef =
                                    FirebaseFirestore.instance
                                        .collection('Student');

                                    // Add the data and get the DocumentReference
                                    DocumentReference docRef =
                                    await collectionRef.add(dataToSave);

                                    setState(() {
                                      globalDocumentId = docRef.id;
                                    });
                                    // Get the ID of the newly added document
                                    if(context.mounted) {
                                      /// push to a new screen
                                    }
                                  } else {
                                    setState(() {
                                      isValidForm = false;
                                    });
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
                                  if(context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                elevation: 0.0,
                              ).copyWith(
                                  elevation:
                                  ButtonStyleButton.allOrNull(0.0)),
                              child: Container(
                                height: 80,
                                width: 300,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Start Order',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          );
        }
      ),
    );
  }
}
