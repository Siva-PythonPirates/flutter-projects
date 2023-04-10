import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'payment_page.dart';

class BookSpotsPage extends StatefulWidget {
  final double pricePerHour;
  final String spotLocation;
  final String spotNumber;

  BookSpotsPage(
      {required this.pricePerHour,
        required this.spotLocation,
        required this.spotNumber});

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
    backgroundColor: Colors.green,
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
    'Spot Location: ${widget.spotLocation}',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Text(
    'Spot Number: ${widget.spotNumber}',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Row(
    children: [
    Text(
    'Duration (in hours)',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(width: 16),
    LimitedBox(
    maxWidth: 100,
    maxHeight: 120,
    child: Container(
    decoration: BoxDecoration(
    border: Border.all(color: Colors.green, width: 2.0),
    borderRadius: BorderRadius.circular(10.0),
    ),
    child: NumberPicker(
    value: _duration,
    minValue: 1,
    maxValue: 24,
    onChanged: (value) {
    setState(() {
    _duration = value;
    });
    },
    ),
    ),
    ),
    ],
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Row(
    children: [
    Expanded(
    child: TextFormField(
    enabled: false,
    decoration: InputDecoration(
    hintText:
    _date == null ? 'Select a date' : _date.toString().split(' ')[0],
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
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                      ),
                    ),
                  ],
                ),
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
                onPressed: () {},
                child: Text('Choose File'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
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
                        builder: (context) => PaymentPage(loc: widget.spotLocation,parkingSpotName: widget.spotLocation, slotNumber: widget.spotNumber, price: widget.pricePerHour * _duration,),
                      ),
                    );
                  }
                },
                child: Text('Proceed to Pay'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
