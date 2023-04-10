import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'history_page.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String num;
  final String location;
  final DateTime bookingTime;
  final String paymentMethod;
  final String cust_name;

  BookingConfirmationPage({
    required this.num,
    required this.location,
    required this.bookingTime,
    required this.paymentMethod,
    required this.cust_name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thank you for booking with us!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Text(
              'Booking Details:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Parking Spot Name: $num',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Location: $location',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Booking Time: ${bookingTime.toString()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Payment Method: $paymentMethod',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Center(
              child: QrImage(
                data: 'Parking Spot: $num\nLocation: $location\nBooking Date & Time: ${bookingTime.toString()}\nPayment Method: $paymentMethod\nCustomer Name: $cust_name',
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Scan the QR code to access your booking details',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'We hope you have a great experience!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingHistoryPage(
                      qrData: 'Parking Spot: $num\nLocation: $location\nBooking Date & Time: ${bookingTime.toString()}\nPayment Method: $paymentMethod\nCustomer Name: $cust_name',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
