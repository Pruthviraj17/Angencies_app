import 'dart:convert';

import 'package:agencies_app/backend_url/config.dart';
import 'package:agencies_app/screens/home_screen.dart';
import 'package:agencies_app/screens/register_screen.dart';
import 'package:agencies_app/transitions_animations/custom_page_transition.dart';
import 'package:agencies_app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController agencyLoginEmail = TextEditingController();
  TextEditingController agencyPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SharedPreferences prefs;

  void _popScreen() {
    Navigator.of(context).pop();
  }

  String? _validateTextField(value, String? label) {
    if (value.isEmpty) {
      return 'Please enter a $label';
    }
    return null;
  }

  void _goToRegisterPage() {
    Navigator.of(context).pushReplacement(
      CustomSlideTransition(
        direction: AxisDirection.up,
        child: const RegisterScreen(),
      ),
    );
  }

  void _navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
      ),
    );
  }

  void _submitButton() {
    if (_formKey.currentState!.validate()) {
      _loginUser();
    }
  }

  void _loginUser() async {
    var reqBody = {
      "username": agencyLoginEmail.text,
      "password": agencyPassword.text,
    };

    var response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    // print(response.statusCode);
    // var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _navigateToHomeScreen();
      print('login successful');
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              foregroundColor: const Color.fromARGB(185, 30, 35, 44),
              side: const BorderSide(
                color: Color.fromARGB(32, 30, 35, 44),
              ),
            ),
            onPressed: _popScreen,
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/disasterImage2.jpg'),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Life Guardian',
                style: TextStyle(
                  color: Color(0xff1E232C),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 7.0),
                      blurRadius: 15.0,
                      color: Color.fromARGB(57, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              const Text(
                'For Agencies',
                style: TextStyle(
                  color: Color(0xff1E232C),
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 7.0),
                      blurRadius: 15.0,
                      color: Color.fromARGB(57, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Welcome back! Glad to see you, team!',
                        style: TextStyle(
                          color: Color(0xff1E232C),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      TextFieldWidget(
                        labelText: 'Email / Phone',
                        controllerText: agencyLoginEmail,
                        checkValidation: (value) =>
                            _validateTextField(value, 'Email / Phone'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFieldWidget(
                        labelText: 'Password',
                        controllerText: agencyPassword,
                        checkValidation: (value) =>
                            _validateTextField(value, 'Password'),
                        obsecureIcon: true,
                        hideText: true,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _submitButton,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xff1E232C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: _goToRegisterPage,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
