import 'package:fitb_pantry_app/order.dart';
import 'package:flutter/material.dart';
import 'information.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    home: MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity, height: 100),
                 const Image(
                    image: AssetImage('assets/fitb.png'),
                  ),
                const SizedBox(height: 250),
                   ElevatedButton(
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage()));
                       },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white,
                       shadowColor: Colors.transparent,
                       elevation: 0.0,
                     ).copyWith(elevation:ButtonStyleButton.allOrNull(0.0)),
                     child:Container(
                     height: 80,
                     width: 220,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                       color: Colors.purple,
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: const Text(
                       'Get Started',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 30,
                       ),
                     ),
                   ), ),

              ],
            ),
          ),
    );
  }
}