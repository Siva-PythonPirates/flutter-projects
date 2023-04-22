import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/views/book_spots_page.dart';
import 'package:parking_app/views/home_page.dart';

import 'views/login_page.dart';
import 'views/payment_page.dart';
import 'views/profile_page.dart';
import 'views/register_user_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
      routes: {
        '/register': (context) => RegistrationPage(),
        '/home':(context) => HomePage(),
      },
      // routes: {
      //   '/booking': (context) => BookSpotsPage(pricePerHour: pricePerHour, spotLocation: spotLocation),
      //   '/payment': (context) => PaymentPage(),
      //   '/profile': (context) => ProfilePage(user: null, bookingHistory: []),
      // },

    );
  }
}
