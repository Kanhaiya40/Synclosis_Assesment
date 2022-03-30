import 'package:flutter/material.dart';
import 'package:synclovis/models/Employee.dart';
import 'package:synclovis/screens/home_screen.dart';
import 'package:synclovis/screens/registration_screen.dart';

import '../database/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper();

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      getLoggedIn(_emailController.text, _passwordController.text);
    }
  }

  void getLoggedIn(String email, String password) async {
    Employee employee = await databaseHelper.getLogin(email, password);
    if (employee != null) {
      _showAlertDialog('Status', 'Login Successfully');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
    } else {
      _showAlertDialog('Status', 'Oops! Something went wrong');
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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text("User Id"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
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
                ElevatedButton(onPressed: _submit, child: const Text("Login")),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Don't have Account yet please "),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const RegistrationScreen();
                        }));
                      },
                      child: const Text(
                        "Signup",
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
