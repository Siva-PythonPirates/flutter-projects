import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final directory = await getApplicationDocumentsDirectory();
                    final filePath = '${directory.path}/user.csv';
                    print('File path: $filePath');
                    final csvFile = File(filePath);
                    List<List<dynamic>> csvList;
                    if (!csvFile.existsSync()) {
                      // Create new CSV file if it doesn't exist
                      csvList = [['Username', 'Password']];
                    } else {
                      // Read existing data from CSV file
                      csvList = const CsvToListConverter().convert(csvFile.readAsStringSync());
                    }
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    bool found = false;
                    for (final row in csvList) {
                      if (row[0] == username) {
                        found = true;
                        break;
                      }
                    }
                    if (found) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Username already exists!'),
                      ));
                    } else {
                      final newRecord = [username, password];
                      csvList.add(newRecord);
                      final csvData = ListToCsvConverter().convert(csvList);
                      await csvFile.writeAsString(csvData);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('User registered successfully!'),
                      ));
                    }

                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
