import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitb_pantry_app/models/group_model/group_model.dart';
import 'package:fitb_pantry_app/models/item_model/item_model.dart';
import 'package:fitb_pantry_app/services/account_service.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

part 'order_summary_page_store.g.dart';

@injectable
class OrderSummaryPageStore = _OrderSummaryPageStore
    with _$OrderSummaryPageStore;

abstract class _OrderSummaryPageStore with Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<GroupModel> orderList;

  _OrderSummaryPageStore(
    this.orderList,
  );

  List<GroupModel> orderSummaryList = [];
  List<ItemModel> orderedItems = [];

  @observable
  bool isLoading = false;

  @observable
  String userSchool = '';

  @observable
  String schoolEmail = '';

  @observable
  String name = '';

  @observable
  String firstName = '';

  @observable
  String lastName = '';

  @action
  Future<void> loadSchoolEmail() async {
    isLoading = true;
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await firestore.collection('Student').doc(AccountService.id).get();
      userSchool = doc.data()?['school'];
      DocumentSnapshot<Map<String, dynamic>> doc2 =
          await firestore.collection('School').doc(userSchool).get();
      schoolEmail = doc2.data()?['Email'];
    } catch (e) {
      print('Error loading user email: $e');
    }

    isLoading = false;
  }

  @action
  Future<void> loadPage() async {
    isLoading = true;

    orderSummaryList = List.from(orderList);
    for (int i = 0; i < orderList.length; i++) {
      for (int j = 0; j < orderList[i].items.length; j++) {
        if (!orderList[i].items[j].ordered) {
          orderSummaryList[i].items.removeAt(j);
          j--;
        } else {
          orderedItems.add(orderList[i].items[j]);
        }
      }
    }

    try {
      CollectionReference studentOrders =
          FirebaseFirestore.instance.collection('Orders');
      DocumentReference studentDocRef =
          firestore.collection('Student').doc(AccountService.id);

      Map<String, dynamic> studentDataToUpdate = {
        'timestamp': FieldValue.serverTimestamp()
      };

      await studentDocRef.update(studentDataToUpdate);

      //Save data to 'Orders' collection
      DocumentSnapshot<Map<String, dynamic>> doc =
          await firestore.collection('Student').doc(AccountService.id).get();

      userSchool = doc.data()?['school'];

      Map<String, dynamic> dataToSave = {
        'items': orderedItems
            .map((item) => {'itemId': item.id, 'quantity': 1})
            .toList(),
        'studentId': AccountService.id,
      };

      // Save the data to the cart items collection
      await studentOrders.doc(AccountService.id).set(dataToSave);
    } catch (e) {
      print("Error: $e");
    }

    isLoading = false;
  }

  @action
  Future<void> sendEmail() async {
    isLoading = true;

    try {
      //get name
      String userSchool = '';
      String phoneNumber = '';
      String userName = '';
      String userEmail = '';

      DocumentSnapshot<Map<String, dynamic>> doc =
          await firestore.collection('Student').doc(AccountService.id).get();
      firstName = doc.data()?['firstName'];
      lastName = doc.data()?['lastName'];
      userSchool = doc.data()?['school'];
      phoneNumber = doc.data()?['phoneNumber'];
      userEmail = doc.data()?['email'];
      userName = '$firstName $lastName';

      final smtpServer =
          gmail('mattknight@fillingintheblanks.org', 'pcokikwhnvrickmk');
      await loadSchoolEmail();

      String orderSummaryHtml = '''
  <html>
    <body style="text-align: center;">
      <header>
        <h1 style="color: #7d1a7b; font-size: 24px;">FILLING IN THE BLANKS</h1>
      </header>
      <h2> 
        <span style="color: #f56e07; font-size: 20px;">
          <strong>Order Summary: $userName</strong>
        </span> 
      </h2>
      <p style="font-size: 16px;">Ordered Items:</p>
      <table style="width: 100%; border-collapse: collapse;">
        <thead>
          <tr>
            <th style="border: 1px solid #ddd; padding: 8px; font-size: 18px;">Group</th>
            <th style="border: 1px solid #ddd; padding: 8px; font-size: 18px;">Items</th>
          </tr>
        </thead>
        <tbody>
''';

      for (int i = 0; i < orderSummaryList.length; i++) {
        orderSummaryHtml += '''
    <tr>
      <td style="border: 1px solid #ddd; padding: 8px;">
        <span style="font-size: 18px;">${orderSummaryList[i].name}</span>
      </td>
      <td style="border: 1px solid #ddd; padding: 8px; font-size: 18px;">
  ''';

        List<String> itemLabels = [];
        for (int j = 0; j < orderSummaryList[i].items.length; j++) {
          itemLabels.add(orderSummaryList[i].items[j].label);
        }

        orderSummaryHtml += itemLabels.join(', ');

        orderSummaryHtml += '''
      </td>
    </tr>
  ''';
      }

      orderSummaryHtml += '''
        </tbody>
      </table>
      <p style="text-align: right; font-size: 16px;">
        Student Details:<br>
        Phone Number: $phoneNumber<br>
        Email: $userEmail<br>
        School: $userSchool
      </p>

    </body>
  </html>
''';

      final message = Message()
        ..from = Address(
            'mattknight@fillingintheblanks.org', 'Filling in the Blanks')
        ..recipients.addAll([schoolEmail, 'mattknight@fillingintheblanks.org'])
        ..subject = 'FITB Order Summary: $userName ${DateTime.now()}'
        ..html = orderSummaryHtml;

      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } catch (e, stackTrace) {
      print('Error sending email: $e');
      print(stackTrace);
    }
    print('Email Sent');
    isLoading = false;
  }
}
