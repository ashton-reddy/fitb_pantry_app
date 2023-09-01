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
  Future<bool> isTodayValidOrderDay(String selectedSchool) async {
    isLoading = true;
    final doc = await firestore.collection("School").doc(selectedSchool).get();
    if (doc.exists) {
      bool isSchoolActive = doc['is active'];
      int weekdayValue = DateTime.now().weekday;
      int openDate = doc['open date'].toInt();
      int closeDate = doc['close date'].toInt();
      if (isSchoolActive == true) {
        if (openDate <= closeDate) {
          isLoading = false;
          return openDate <= weekdayValue && weekdayValue <= closeDate;
        } else {
          isLoading = false;
          return weekdayValue >= openDate || weekdayValue <= closeDate;
        }
      } else {
        isLoading = false;
        return false;
      }
    }
    isLoading = false;
    return false;
  }
}
