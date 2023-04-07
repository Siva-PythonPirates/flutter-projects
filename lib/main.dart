import 'package:flutter/material.dart';
import 'package:parking_app/views/book_spots_page.dart';

import 'views/login_page.dart';
import 'views/payment_page.dart';
import 'views/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      // routes: {
      //   '/booking': (context) => BookSpotsPage(pricePerHour: pricePerHour, spotLocation: spotLocation),
      //   '/payment': (context) => PaymentPage(),
      //   '/profile': (context) => ProfilePage(user: null, bookingHistory: []),
      // },

    );
  }
}
