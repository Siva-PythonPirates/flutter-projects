import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:parking_app/views/payment_page.dart';

import 'book_spots_page.dart';

class ParkingSpotDetailsPage extends StatefulWidget {
  final String name;
  final String location;
  final bool isAvailable;
  final double price;
  final int availableSpaces;
  final int index =0;
  int _duration =1;
  ParkingSpotDetailsPage({
    required this.name,
    required this.location,
    required this.isAvailable,
    required this.price,
    required this.availableSpaces,
  });

  @override
  _ParkingSpotDetailsPageState createState() => _ParkingSpotDetailsPageState();
}

class _ParkingSpotDetailsPageState extends State<ParkingSpotDetailsPage> {
  DateTime _selectedDate = DateTime.now();
  int _duration = 1;
  double _totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    _totalPrice = widget.price * _duration;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location: ${widget.location}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Availability: ${widget.availableSpaces > 0 ? 'Available' : 'Not Available'}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.availableSpaces > 0 ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Price: ${widget.price.toStringAsFixed(2)} per hour',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select date:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            _selectedDate = value;
                          });
                        }
                      });
                    },
                    child: Text(
                      _selectedDate.toString().substring(0, 10),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select duration:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  NumberPicker(
                    value: _duration,
                    minValue: 1,
                    maxValue: 24,
                    onChanged: (value) {
                      setState(() {
                        _duration = value;

                      });
                    },
                  ),
                ],
              ),

              Text(
                'Available Slots:',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 16),
GridView.count(
physics: NeverScrollableScrollPhysics(),
shrinkWrap: true,
crossAxisCount: 4,
children: List.generate(
widget.availableSpaces,
(index) => GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => BookSpotsPage(
pricePerHour: widget.price, spotLocation: widget.name,
),
),
);
},
child: Container(
margin: EdgeInsets.all(4),
decoration: BoxDecoration(
color: Colors.green,
borderRadius: BorderRadius.circular(8),
),
child: Center(
child: Text(
'${index + 1}',
style: TextStyle(
fontSize: 24,
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
),
),
).toList() +
List.generate(
20 - widget.availableSpaces,
(index) => GestureDetector(
onTap: () {
showDialog(
context: context,
builder: (context) => BackdropFilter(
filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
child: AlertDialog(
title: Text('Slot Already Booked'),
content: Text('Sorry, this slot is already booked.'),
actions: [
TextButton(
onPressed: () => Navigator.pop(context),
child: Text('OK'),
),
],
),
),
);
},
child: Container(
margin: EdgeInsets.all(4),
decoration: BoxDecoration(
color: Colors.red,
borderRadius: BorderRadius.circular(8),
),
child: Center(
child: Text(
'${widget.availableSpaces + index + 1}',
style: TextStyle(
fontSize: 24,
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
),
),
).toList(),
),
],
),
),
      ),
);
}
}