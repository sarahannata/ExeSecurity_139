import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final Function(String) onLocationSelected;
  const MapView({super.key, required this.onLocationSelected});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  LatLng? lastMapPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lastMapPosition = LatLng(position.latitude, position.longitude);
    });
    mapController.animateCamera(CameraUpdate.newLatLng(lastMapPosition!));
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (lastMapPosition != null) {
      setState(() {
        mapController.animateCamera(CameraUpdate.newLatLng(lastMapPosition!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        buildingsEnabled: true,
        trafficEnabled: true,
        compassEnabled: true,
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: lastMapPosition ?? const LatLng(0.0, 0.0),
          zoom: 15.0,
        ),
        markers: {
          if (lastMapPosition != null)
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: lastMapPosition!,
            )
        },
        onTap: (position) {
          setState(() {
            lastMapPosition = position;
          });
        },
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () async {
              if (lastMapPosition != null) {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  lastMapPosition!.latitude,
                  lastMapPosition!.longitude,
                );

                if (placemarks.isNotEmpty) {
                  Placemark place = placemarks[0];
                  String fullAddress =
                      "${place.name},${place.street},${place.subLocality},${place.locality},${place.postalCode},${place.country}";
                  widget.onLocationSelected(fullAddress);
                } else {
                  widget.onLocationSelected("No address found");
                }

                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
