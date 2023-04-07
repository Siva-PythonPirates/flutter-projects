import 'package:flutter/material.dart';

class BookSpotsPage extends StatefulWidget {
  final double pricePerHour;
  final String spotLocation;

  BookSpotsPage({required this.pricePerHour, required this.spotLocation});

  @override
  _BookSpotsPageState createState() => _BookSpotsPageState();
}

class _BookSpotsPageState extends State<BookSpotsPage> {
  final _formKey = GlobalKey<FormState>();
  final _durationController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _idProofController = TextEditingController();
  int _duration = 0;



  @override
  void dispose() {
    _durationController.dispose();
    _vehicleNumberController.dispose();
    _customerNameController.dispose();
    _idProofController.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    final duration = int.parse(_durationController.text);
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Duration (in hours)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  _duration = int.parse(value!);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date of Booking (MM/DD/YYYY)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date of booking';
                  }
                  return null;
                },
                onSaved: (value) {
                },
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
                    // TODO: Navigate to payment page
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

