import 'package:dars72_location/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
  LocationData? myLocation;

  LatLng najotTalim = const LatLng(41.2856806, 69.2034646);
  LatLng najotTalimOldidagiMagazin = const LatLng(41.2856806, 69.2045946);
  LatLng? meningJoylashuvim;
  List<LatLng> myPositions = [];
  Set<Marker> myMarkers = {};
  Set<Polyline> polylines = {};

  // @override
  // void initState() {
  //   super.initState();

  //   Future.delayed(Duration.zero, () async {
  //     await LocationService.fetchCurrentLocation();

  //     setState(() {
  //       myLocation = LocationService.currentLocation;
  //     });

  //     LocationService.fetchLiveLocation().listen((location) {
  //       setState(() {
  //         myLocation = location;
  //       });
  //     });
  //   });
  // }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void onCameraMove(CameraPosition position) {
    meningJoylashuvim = position.target;
    setState(() {});
  }

  void addMarker() async {
    myMarkers.add(
      Marker(
        markerId: MarkerId(UniqueKey().toString()),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
        position: meningJoylashuvim!,
      ),
    );

    myPositions.add(meningJoylashuvim!);

    if (myPositions.length == 2) {
      final points = await LocationService.getPolylines(
        myPositions[0],
        myPositions[1],
      );

      polylines.add(
        Polyline(
          polylineId: PolylineId(UniqueKey().toString()),
          color: Colors.blue,
          width: 5,
          points: points,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.zoomOut(),
              );
            },
            icon: const Icon(Icons.remove_circle),
          ),
          IconButton(
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.zoomIn(),
              );
            },
            icon: const Icon(Icons.add_circle),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            buildingsEnabled: true,
            onCameraMove: onCameraMove,
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: najotTalim,
              zoom: 15,
            ),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: {
              Marker(
                markerId: MarkerId("NajotTalim"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueCyan,
                ),
                position: najotTalim,
                infoWindow: const InfoWindow(
                  title: "Najot Talim",
                  snippet: "Xush Kelibsiz",
                ),
              ),
              Marker(
                markerId: MarkerId("NajotTalimOldidagiMagazin"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange,
                ),
                position: najotTalimOldidagiMagazin,
                infoWindow: const InfoWindow(
                  title: "Najot Talim Oldidagi Magazin",
                  snippet: "Xush Kelibsiz",
                ),
              ),
              Marker(
                markerId: MarkerId("MeningJoylashuvim"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure,
                ),
                position: meningJoylashuvim ?? najotTalim,
                infoWindow: const InfoWindow(
                  title: "Bu MEN",
                  snippet: "Xush Kelibsiz",
                ),
              ),
              ...myMarkers
            },
            polylines: polylines,
          ),
          // const Align(
          //   child: Icon(
          //     Icons.place,
          //     color: Colors.teal,
          //     size: 60,
          //   ),
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: addMarker,
        child: const Icon(Icons.add),
      ),
    );
  }
}
