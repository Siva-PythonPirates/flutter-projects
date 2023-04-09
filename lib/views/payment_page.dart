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
      double price,
      String paymentMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your payment was successful!'),
              SizedBox(height: 16),
              Text('Payment Method: $paymentMethod'),
            ],
          ),
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
                          paymentMethod: paymentMethod,
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
      _showPaymentSuccessDialog(context, widget.parkingSpotName, widget.slotNumber, widget.price, _selectedPaymentMethod ?? 'Unknown');

    } else {
      _showPaymentFailureDialog(context);
    }
  }

  Widget _buildPaymentMethodRadioTile(String paymentMethod, IconData icon) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Text(paymentMethod),
        ],
      ),
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
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
          color: Colors.green
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
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
      decoration: InputDecoration(
        labelText: 'Car Number',
        labelStyle: TextStyle(
          color: Colors.green
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
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



  Widget _buildPaymentMethodIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = 'Visa';
            });
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _selectedPaymentMethod == 'Visa' ? Colors.green[200] : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(Icons.credit_card),
              ),
              SizedBox(height: 8),
              Text('Visa', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = 'Mastercard';
            });
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _selectedPaymentMethod == 'Mastercard' ? Colors.green[200] : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(Icons.credit_card),
              ),
              SizedBox(height: 8),
              Text('Mastercard', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = 'PayPal';
            });
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _selectedPaymentMethod == 'PayPal' ? Colors.green[200] : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(Icons.payments),
              ),
              SizedBox(height: 8),
              Text('PayPal', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  'Price: ${widget.price }',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 16),

                Text(
                  'Select Payment Method:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                _buildPaymentMethodIcons(),
                SizedBox(height: 16),
                Text(
                  'Enter Payment Details:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                _buildNameTextField(),
                SizedBox(height: 8),
                _buildCarNumberTextField(),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _processPayment(context),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
