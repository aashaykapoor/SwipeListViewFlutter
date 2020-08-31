import 'dart:async';

import 'package:SwipeList/services/locationservice.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> controller = Completer();
  Position position;
  String addr;
  MapType current = MapType.normal;

  @override
  void initState() {
    LocationService().getCurrentLocation().then((value) {
      this.position = value;
     

      setState(() {});


    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return position == null
        ? Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          )
        : Container(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 15.0),
              markers: [
                Marker(
                    markerId: MarkerId("0"),
                    position: LatLng(position.latitude, position.longitude))
              ].toSet(),
            ),
          );
  }
}
