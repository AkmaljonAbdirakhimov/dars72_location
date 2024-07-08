import 'package:dars72_location/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationData? myLocation;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await LocationService.fetchCurrentLocation();

      setState(() {
        myLocation = LocationService.currentLocation;
      });

      LocationService.fetchLiveLocation().listen((location) {
        setState(() {
          myLocation = location;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          myLocation == null
              ? "Joylashuv ololmadim ruxsat berilmadi"
              : "Lat: ${myLocation!.latitude} va Lon: ${myLocation!.longitude}",
        ),
      ),
    );
  }
}
