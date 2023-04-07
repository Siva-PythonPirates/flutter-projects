import 'package:flutter/material.dart';
import 'package:parking_app/models/booking.dart';
import 'package:parking_app/models/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  final List<Booking> bookingHistory;

  const ProfilePage({
    Key? key,
    required this.user,
    required this.bookingHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text('Name: ${user.name}'),
            SizedBox(height: 8.0),
            Text('Email: ${user.email}'),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'Booking History',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 16.0),
            bookingHistory.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bookingHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Booking on ${bookingHistory[index].date}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text('Spot Name: ${bookingHistory[index].spotName}'),
                      SizedBox(height: 8.0),
                      Text('Duration: ${bookingHistory[index].duration} hours'),
                      SizedBox(height: 8.0),
                      Text('Total Price: ${bookingHistory[index].totalPrice}'),
                    ],
                  ),
                );
              },
            )
                : Center(
              child: Text('No bookings found.'),
            ),
          ],
        ),
      ),
    );
  }
}
