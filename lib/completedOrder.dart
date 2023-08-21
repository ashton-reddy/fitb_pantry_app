import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitb_pantry_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, home: CompletedOrderPage()));
}

class CompletedOrderPage extends StatefulWidget {
  const CompletedOrderPage({super.key});

  @override
  State<CompletedOrderPage> createState() => _CompletedOrderPageState();
}

class _CompletedOrderPageState extends State<CompletedOrderPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
