import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class maphome extends StatefulWidget {
  const maphome({super.key});

  @override
  State<maphome> createState() => _maphomeState();
}

class _maphomeState extends State<maphome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "map",
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: OpenStreetMapSearchAndPick(
          center: LatLong(22.4625633, 87.970121),
          onPicked: (pickedData) {
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
            print(pickedData.address);
          }),
    );
  }
}
