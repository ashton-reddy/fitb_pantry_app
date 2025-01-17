import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitb_pantry_app/services/account_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'login_page_store.g.dart';

@injectable
class LoginPageStore = _LoginPageStore with _$LoginPageStore;

abstract class _LoginPageStore with Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _LoginPageStore();

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
  Future<bool> canStudentOrder(String docId) async {
    isLoading = true;
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('Orders').get();
    for (var document in snap.docs) {
      if (document.id == docId) {
        isLoading = false;
        return false;
      }
    }
    isLoading = false;
    return true;
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
      bool isSchoolActive = doc['Is active'];
      int weekdayValue = DateTime.now().weekday;
      int openDate = doc['Open date'].toInt();
      int closeDate = doc['Close date'].toInt();
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

      await collectionRef.doc(email).set(dataToSave);
      AccountService.id = email;
      AccountService.email = email;
    }
    isLoading = false;

    return isValidOrderDay;
  }
}
