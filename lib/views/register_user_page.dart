import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize Firebase app and database reference
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text('Username'),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Password'),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Phone Number'),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Email'),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _register();
                Map<String, String> login = {
                  // 'name': 'Parking Spot 1',
                  // 'location': GeoPoint(13.0881, 13.0881, 80.2838),
                  // 'availableSpaces' : 10,

                  // 'name': 'Parking Spot 1',
                  // 'latitude': 37.7749.toString(),
                  // 'longitude': (0-122.4194).toString(),
                  // 'available_spaces': 10.toString(),

                  'username': _usernameController.text,
                  'password': _passwordController.text,
                  'phone_number': _phoneController.text,
                  'email_id': _emailController.text,
                };
                FirebaseFirestore.instance.collection('login_info').doc().set(login);

              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;

    print('Username: $username');
    print('Password: $password');
    print('Phone: $phone');
    print('Email: $email');
  }
}

