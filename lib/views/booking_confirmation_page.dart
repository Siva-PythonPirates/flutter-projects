import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String name;
  final String location;
  final DateTime bookingTime;
  final String paymentMethod;

  BookingConfirmationPage({
    required this.name,
    required this.location,
    required this.bookingTime,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
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
              'Parking Spot Name: $name',
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
                data: 'Parking Spot: $name\nLocation: $location\nBooking Time: ${bookingTime.toString()}\nPayment Method: $paymentMethod',
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
          ],
        ),
      ),
    );
  }
}
