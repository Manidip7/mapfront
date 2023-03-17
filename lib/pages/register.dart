import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'package:map/pages/loginpage.dart';
import 'package:map/utils/utils.dart';
import 'package:map/widgets/round_butten.dart';
import 'package:shared_preferences/shared_preferences.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _addressController = TextEditingController();
  final _name = TextEditingController();

  void clearText() {
    _name.clear();
    _emailController.clear();
    _passWordController.clear();
    _addressController.clear();
  }

  void register() async {
    setState(() {
      loading = true;
    });
    try {
      Map<String, dynamic> map = {
        'name': _name.text.toString().trim(),
        'email': _emailController.text.toString().trim(),
        'password': _passWordController.text.toString().trim(),
        'address': _addressController.text.toString().trim(),
      };
      var body = json.encode(map);
      var encoding = Encoding.getByName('utf-8');
      const headers = {"Content-Type": "application/json"};
      Response response = await http.post(
          Uri.parse('https://mapautt-production.up.railway.app/register'),
          headers: headers,
          body: body,
          encoding: encoding);
      if (response.statusCode == 200) {
        print('account created');
        setState(() {
          Util().toastMessage("Account created");
          loading = false;
        });
        clearText();
      } else {
        print("Error");
        Utils().toastMessage("Account alrady created");
        setState(() {
          loading = false;
        });
        clearText();
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
      print(e);
      clearText();
    }
  }

  // FirebaseAuth _auth = FirebaseAuth.instance;

  // User? currentUser;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    _name.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/login_image.png",
                fit: BoxFit.cover,
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _name,
                          keyboardType: TextInputType.name,
                          // showCursor: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepPurpleAccent, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(
                                Icons.account_circle,
                                size: 28,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your user email.';
                            }
                            // return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          // showCursor: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepPurpleAccent, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(
                                Icons.email,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your user email.';
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Enter Correct Email Address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passWordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          // showCursor: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurpleAccent, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your user password.';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _addressController,
                          // obscureText: true,
                          keyboardType: TextInputType.name,
                          // showCursor: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Adderss",
                            prefixIcon: Icon(
                              Icons.start,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurpleAccent, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your user Address.';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButten(
                  title: "Register",
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      register();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginpage()));
                      },
                      child: Text(
                        "Login now",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
