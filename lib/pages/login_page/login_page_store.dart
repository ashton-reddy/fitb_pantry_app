import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'login_page_store.g.dart';

@injectable
class LoginPageStore = _LoginPageStore with _$LoginPageStore;

abstract class _LoginPageStore with Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _LoginPageStore();

  String docId = '';

  @observable
  bool isLoading = false;

  @observable
  List<DropdownMenuItem> schoolsList = [];

  @action
  Future<void> loadPage() async {
    isLoading = true;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("School").get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      DocumentSnapshot snap = snapshot.docs[i];
      schoolsList.add(
        DropdownMenuItem(
          value: snap.id,
          child: Text(
            snap.id,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }
    isLoading = false;
  }

  @action
  Future<bool> isTodayValidOrderDay(
    String selectedSchool,
    String phoneNumber,
    String email,
    String firstName,
    String lastName,
    String school,
  ) async {
    isLoading = true;
    bool isValidOrderDay = false;
    final doc = await firestore.collection("School").doc(selectedSchool).get();
    if (doc.exists) {
      bool isSchoolActive = doc['is active'];
      int weekdayValue = DateTime.now().weekday;
      int openDate = doc['open date'].toInt();
      int closeDate = doc['close date'].toInt();
      if (isSchoolActive == true) {
        if (openDate <= closeDate) {
          isValidOrderDay =
              openDate <= weekdayValue && weekdayValue <= closeDate;
        } else {
          isValidOrderDay =
              weekdayValue >= openDate || weekdayValue <= closeDate;
        }
      } else {
        isValidOrderDay = false;
      }
    }

    if (isValidOrderDay) {
      Map<String, dynamic> dataToSave = {
        'phoneNumber': phoneNumber,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'school': school,
      };
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('Student');

      DocumentReference docRef = await collectionRef.add(dataToSave);
      docId = docRef.id;
    }
    isLoading = false;

    return isValidOrderDay;
  }
}
