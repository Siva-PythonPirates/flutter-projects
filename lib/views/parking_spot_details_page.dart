import 'package:flutter/material.dart';
import 'package:parking_app/views/payment_page.dart';

class ParkingSpotDetailsPage extends StatelessWidget {
  final String name;
  final String location;
  final bool isAvailable;
  final double price;
  final int availableSpaces;

  ParkingSpotDetailsPage({
    required this.name,
    required this.location,
    required this.isAvailable,
    required this.price,
    required this.availableSpaces,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location: $location',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Availability: ${isAvailable ? 'Available' : 'Not Available'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Price: \$${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 32),
            Text(
              'Available Slots:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              children: List.generate(
                availableSpaces,
                    (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          parkingSpotName: name,
                          slotNumber: index + 1,
                          price: price,
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
              ).toList() + List.generate(
                20 - availableSpaces,
                    (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          parkingSpotName: name,
                          slotNumber: availableSpaces + index + 1,
                          price: price,
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
                        '${availableSpaces + index + 1}',
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
    );
  }
}
