import 'package:flutter/material.dart';
import 'information.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrderPage()));
}
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity, height: 100),
          const Image(
            image: AssetImage('assets/fitb.png'),
          ),
          const SizedBox(height: 250),
        ],
      ),
    );
  }
}