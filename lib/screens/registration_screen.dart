import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synclovis/models/Employee.dart';
import 'package:synclovis/screens/login_screen.dart';

import '../database/database_helper.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper();
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _mobileController = TextEditingController();
  var _passwordController = TextEditingController();

  void saveDataToDatabase(Employee employee) async {
    int result;
    result = await databaseHelper.saveUser(employee);
    if (result != 0) {
      _showAlertDialog('Status', 'Registration Successfully');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const RegistrationScreen();
      }));
    } else {
      _showAlertDialog('Status', 'Oops! Something went wrong');
    }
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Employee employee = Employee(_nameController.text, _emailController.text,
          _mobileController.text, _passwordController.text);
      saveDataToDatabase(employee);
    }
  }

  void _showAlertDialog(String status, String message) {
    //note.date = DateFormat.yMMMd().format(DateTime.now());
    AlertDialog alertDialog = AlertDialog(
      title: Text(status),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _mobileController,
                  decoration: const InputDecoration(
                    label: Text("Mobile"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: _submit, child: const Text("Register")),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Already Registered?"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
