import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:parking_app/views/parking_spot_details_page.dart';

import 'payment_page.dart';

class BookSpotsPage extends StatefulWidget {
  final double pricePerHour;
  final String spotLocation;

  BookSpotsPage({required this.pricePerHour, required this.spotLocation});

  @override
  _BookSpotsPageState createState() => _BookSpotsPageState();
}

class _BookSpotsPageState extends State<BookSpotsPage> {
  final _formKey = GlobalKey<FormState>();
  int _duration = 1;
  DateTime? _date;

  final _vehicleNumberController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _idProofController = TextEditingController();

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _customerNameController.dispose();
    _idProofController.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spot Location: ${widget.spotLocation}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16),

              Text(
                'Duration (in hours)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
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

              SizedBox(height: 16),

              Text(
                'Date of Booking',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: _date == null ? 'Select a date' : _date.toString().split(' ')[0],
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (_date == null) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text('Select'),
                  ),
                ],
              ),

              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Vehicle Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle number';
                  }
                  return null;
                },
                onSaved: (value) {
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter customer name';
                  }
                  return null;
                },
                onSaved: (value) {
                },
              ),
              SizedBox(height: 16),
              Text(
                'Upload ID Proof:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement file picker to upload ID proof
                },
                child: Text('Choose File'),
              ),
              SizedBox(height: 16),

              Text(
                'Total Price: ${_duration * widget.pricePerHour}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(parkingSpotName: '', slotNumber: 0, price: widget.pricePerHour * _duration,),
                      ),
                    );
                  }
                },
                child: Text('Proceed to Pay'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

