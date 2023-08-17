import 'order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Information()));
}

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

int weekdaysValue = DateTime.now().weekday;
//CollectionReference collection =
  //  FirebaseFirestore.instance.collection('School');
Timestamp timestamp = Timestamp.fromDate(DateTime(weekdaysValue));
final DateTime now = DateTime.now();
final builder1 = ValidationBuilder().phone();
DateTime? closeDate;
final builder2 = ValidationBuilder().email();
final TextInputFormatter digitsOnly =
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'));
var _numberForm = GlobalKey<FormState>();
bool isValidForm = false;
var selectedSchool1;
TextEditingController _controllerPhone = TextEditingController();
TextEditingController _controllerEmail = TextEditingController();
TextEditingController _controllerFirst = TextEditingController();
TextEditingController _controllerLast = TextEditingController();
TextEditingController _controllerSchool = TextEditingController();

class _InformationState extends State<Information> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _controllerPhone,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                        ),
                        hintText: 'Phone Number',
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 300),
                      ),
                      validator: builder1.maxLength(15).build(),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _controllerEmail,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                        ),
                        hintText: "Email",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 300),
                      ),
                      validator: builder2.maxLength(50).build(),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _controllerFirst,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                        ),
                        hintText: "First Name",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 300),
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
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _controllerLast,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                        ),
                        hintText: "Last Name",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 300),
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
                    SizedBox(height: 25),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("School")
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Text("Loading.....");
                        } else {
                          List<DropdownMenuItem> listOfSchools = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data.docs[i];
                            listOfSchools.add(
                              DropdownMenuItem(
                                child: Text(
                                  snap.id,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                value: snap.id,
                              ),
                            );
                          }
                          return Column(
                            children: [
                              SizedBox(
                                width: 300,
                                child: DropdownButtonFormField(
                                  items: listOfSchools,
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
                              SizedBox(height: 25),
                              ElevatedButton(
                                onPressed: () async {
                                  bool isFormEnabled =
                                      await isTodayValidOrderDay(
                                          selectedSchool1);

                                  if (isFormEnabled) {
                                    if (_numberForm.currentState!.validate()) {
                                      setState(() {
                                        isValidForm = true;
                                      });
                                      Map<String, String> dataToSave = {
                                        'phone number': _controllerPhone.text,
                                        'email': _controllerEmail.text,
                                        'first name': _controllerFirst.text,
                                        'last name': _controllerLast.text,
                                        'school': _controllerSchool.text,
                                      };
                                      CollectionReference collectionRef =
                                          FirebaseFirestore.instance
                                              .collection('Information');
                                      collectionRef.add(dataToSave);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrderPage()),
                                      );
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
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
                                  child: const Text(
                                    'Order',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                  height: 60,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration (
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Future<bool> isTodayValidOrderDay(String selectedSchool) async {
    try {
      // Retrieve the information for the school
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('School')
          .doc(selectedSchool)
          .get();

      // If the school is not active, return false

      // Check if the day is in the range
      if (documentSnapshot.exists) {
        bool isSchoolActive = documentSnapshot['is active'];
        int weekdayValue = DateTime.now().weekday;
        int openDate = documentSnapshot['open date'].toInt();
        int closeDate = documentSnapshot['close date'].toInt();
        if (isSchoolActive == true) {
          if (openDate <= closeDate) {
            return openDate <= weekdayValue && weekdayValue <= closeDate;
          } else {
            return weekdayValue >= openDate || weekdayValue <= closeDate;
          }
        } else {
          return false;
        }
      }

      return false;
    } catch (e) {
      print('Error fetching weekdays from Firestore: $e');
      return false;
    }
  }
}
