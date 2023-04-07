import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingHistoryPage extends StatefulWidget {
  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  List<Map<String, dynamic>> bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bookingsJson = prefs.getString('bookings');
    if (bookingsJson != null) {
      List<dynamic> bookingsList = jsonDecode(bookingsJson);
      setState(() {
        bookings = bookingsList.cast<Map<String, dynamic>>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
      ),
      body: bookings.isNotEmpty
          ? ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> booking = bookings[index];
          return ListTile(
            title: Text(booking['spotName']),
            subtitle: Text(booking['date']),
            trailing: Text('\$${booking['price']}'),
          );
        },
      )
          : Center(
        child: Text('No bookings found.'),
      ),
    );
  }
}