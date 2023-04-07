import 'package:flutter/material.dart';
import 'booking_confirmation_page.dart';

class PaymentPage extends StatefulWidget {
  final String parkingSpotName;
  final int slotNumber;
  final double price;

  PaymentPage({
    required this.parkingSpotName,
    required this.slotNumber,
    required this.price,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;
  String? _name;
  String? _carNumber;

  void _showPaymentSuccessDialog(BuildContext context,
      String parkingSpotName,
      int slotNumber,
      double price,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your payment was successful!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BookingConfirmationPage(
                          name: parkingSpotName,
                          location: 'Example Location',
                          bookingTime: DateTime.now(),
                        ),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _showPaymentFailureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Failed'),
          content: Text('Your payment failed. Please try again later.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _processPayment(BuildContext context) async {
    // Perform payment logic here
    await Future.delayed(Duration(seconds: 2));

    // Check if payment was successful
    bool paymentSuccessful = true; // Replace with actual payment logic

    if (paymentSuccessful) {
      _showPaymentSuccessDialog(context, widget.parkingSpotName, widget.slotNumber, widget.price);

    } else {
      _showPaymentFailureDialog(context);
    }
  }

  Widget _buildPaymentMethodRadioTile(String paymentMethod) {
    return RadioListTile<String>(
      title: Text(paymentMethod),
      value: paymentMethod,
      groupValue: _selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _buildCarNumberTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Car Number'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your car number';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _carNumber = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parking Spot: ${widget.parkingSpotName}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Slot Number: ${widget.slotNumber}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Price: ${widget.price}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _processPayment(context),
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}