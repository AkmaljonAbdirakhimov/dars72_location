import 'package:dars72_location/screens/home_screen.dart';
import 'package:dars72_location/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // PermissionStatus cameraPermission = await Permission.camera.status;
  // PermissionStatus locationPermission = await Permission.location.status;

  // print(cameraPermission);
  // if (cameraPermission == PermissionStatus.denied) {
  //   cameraPermission = await Permission.camera.request();
  //   print(cameraPermission);
  // }

  // if (locationPermission == PermissionStatus.denied) {
  //   locationPermission = await Permission.location.request();
  //   print(locationPermission);
  // }

  // final statuses = await [
  //   Permission.location,
  //   Permission.camera,
  // ].request();

  // print(statuses);
  // print(statuses[Permission.location]);

  await LocationService.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
