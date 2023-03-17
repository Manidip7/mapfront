import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:map/pages/dasbord.dart';
import 'package:map/pages/map.dart';

import 'package:map/pages/register.dart';
import 'package:map/utils/utils.dart';
import 'package:map/widgets/round_butten.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool loding = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();

  late SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    preferences = await SharedPreferences.getInstance();
  }

  // User? currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passWordController.dispose();
  }

  void login() async {
    setState(() {
      loding = true;
    });
    try {
      Map<String, dynamic> map = {
        'email': _emailController.text.toString().trim(),
        'password': _passWordController.text.toString().trim(),
      };
      var body = json.encode(map);
      var encoding = Encoding.getByName('utf-8');
      const headers = {"Content-Type": "application/json"};
      Response response = await http.post(
          Uri.parse('https://mapautt-production.up.railway.app/signin'),
          headers: headers,
          body: body,
          encoding: encoding);
      // if (response.statusCode == 200) {
      //   print('i am happy');
      // } else {
      //   print("Error");
      // }
      var resp = jsonDecode(response.body);
      if (resp['status']) {
        var myToken = resp['token'];
        preferences.setString('token', myToken);
        Util().toastMessage("login Successfuly");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => dasscreen(token: myToken)));
        setState(() {
          loding = false;
        });
      } else {
        print("somthing went wrong");
        Utils().toastMessage("Somthing went wrong");
        setState(() {
          loding = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/loginlogo.png",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "LOGIN",
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
                              // floatingLabelStyle: TextStyle(
                              //     color: Colors.deepPurpleAccent,
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.w300),
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
                            // floatingLabelStyle: TextStyle(
                            //     color: Colors.deepPurpleAccent,
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w300),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your user password.';
                            }
                          },
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButten(
                  title: "Login",
                  loading: loding,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => register()));
                      },
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent),
                      ))
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => maphome()));
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
