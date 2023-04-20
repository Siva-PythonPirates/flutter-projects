import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 32.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final directory = await getApplicationDocumentsDirectory();
                        final filePath = join(directory.path, 'user.csv');
                        final textFile = File(filePath);
                        if (!await textFile.exists()) {
                          // If the file doesn't exist, create it and write an empty list to it.
                          await textFile.create(recursive: true);
                          await textFile.writeAsString(const ListToCsvConverter().convert([]));
                        }
                        final text = await textFile.readAsString();
                        final csvList = const CsvToListConverter().convert(text);
                        final credentials = csvList.map((row) => '${row[0]}:${row[1]}').toList();
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        bool found = false;
                        for (final credential in credentials) {
                          final credentialParts = credential.split(':');
                          if (credentialParts[0] == username && credentialParts[1] == password) {
                            found = true;
                            break;
                          }
                        }
                        if (found) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Logged in successfully!'),
                          ));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Invalid username or password'),
                          ));
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text('New user? Register here.'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

