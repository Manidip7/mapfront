import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class profil extends StatefulWidget {
  late String name, email, address;

  profil({required this.name, required this.email, required this.address});

  @override
  State<profil> createState() => _profilState();
}

class _profilState extends State<profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5F3),
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CircleAvatar(
                      child: Image.asset(
                        "assets/images/pr.png",
                        fit: BoxFit.cover,
                      ),
                      backgroundColor: Colors.amber,
                      minRadius: 50,
                      maxRadius: 50,
                    ),
                  ),
                ),
                Text(
                  '${widget.name}',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.email}',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('${widget.address}',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
