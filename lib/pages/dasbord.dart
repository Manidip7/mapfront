import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:map/pages/map.dart';

import 'package:map/pages/profile.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class dasscreen extends StatefulWidget {
  final String token;
  const dasscreen({required this.token, super.key});

  @override
  State<dasscreen> createState() => _dasscreenState();
}

class _dasscreenState extends State<dasscreen> {
  late String email;
  late String name;
  late String address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    name = jwtDecodedToken['name'];
    address = jwtDecodedToken['address'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: Image.asset(
                  "assets/images/home.png",
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                // color: Colors.green,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),

                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: GridView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => profil(
                                            name: name,
                                            email: email,
                                            address: address)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 5),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/profile.png",
                                      fit: BoxFit.cover,
                                      height: 70,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "PROFILE",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => maphome()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 5),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/map.png",
                                      fit: BoxFit.cover,
                                      height: 70,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "LOCATION",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10)),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
