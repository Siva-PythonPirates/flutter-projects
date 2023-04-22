import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import '../views/login_page.dart';

class ProfilePage extends StatefulWidget {
  final String loggedInUsername;

  const ProfilePage({Key? key, required this.loggedInUsername}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  List<dynamic> user = [];
  late List<String> credentials;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    loadUserData();
  }


  Future<void> loadUserData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/user_info.csv';
      final csvFile = File(filePath);
      if (await csvFile.exists()) {
        final text = await csvFile.readAsString();
        final csvList = const CsvToListConverter().convert(text);
        print('csvList');
        print(csvList);
        //user = csvList.firstWhere((row) => row[0] == widget.loggedInUsername, orElse: () => []);
        credentials = csvList.map((row) => '${row[0]}:${row[1]}:${row[2]}:${row[3]}').toList();

        print('credentials');
        print(credentials);
        final username = _usernameController.text;

        bool found = false;
        for (final credential in credentials) {
          final credentialParts = credential.split(':');
          print('credParts');
          print(credentialParts);
          if (credentialParts[0] == username) {
            _usernameController.text = credentialParts[0];
            //print(_usernameController.text);
            _passwordController.text = credentialParts[2];
            _emailController.text = credentialParts[1];
            _phoneController.text = credentialParts[3];
            found = true;
            break;
          }

          //print(credentialParts); // [[hello, world], [goodbye], [foo, bar]]


        }
    }} catch (e) {
      print('Error loading user data: $e');
    }
  }
  List<String> user_details = [];

  @override
  Widget build(BuildContext context) {


    // print(user_details);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              const Text(
                'Username',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(

                '${_usernameController.text}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${_emailController.text}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${_passwordController.text}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Phone',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${_phoneController.text}',
                style: const TextStyle(fontSize: 16),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
