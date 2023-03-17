import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:map/pages/loginpage.dart';
import 'package:map/pages/register.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class wellcome extends StatelessWidget {
  const wellcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Image.asset(
              "assets/images/well.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            GradientText(
              "  <WELLCOME/>",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              colors: [Colors.deepPurpleAccent, Colors.black87],
            ),
            SizedBox(
              height: 30,
            ),
            GradientText(
              "FIND YOUR",
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              colors: [Colors.deepPurpleAccent, Colors.black87],
            ),
            SizedBox(
              height: 30,
            ),
            GradientText(
              "LOCATION",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              colors: [Colors.deepPurpleAccent, Colors.black87],
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginpage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(10)),
                  height: 60,
                  child: Center(
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
