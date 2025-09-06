import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🚚 Driver Home', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 150.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome Driver",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Driver Profile",
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(Icons.account_circle_outlined, size: 40, color: Colors.white),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Settings', style: TextStyle(fontSize: 16)),
              onTap: () {},
              leading: Icon(Icons.settings, color: Colors.deepPurple),
            ),
            ListTile(
              title: Text('About', style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.info_outline, color: Colors.deepPurple),
            ),
            Expanded(child: Container()),
            Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: ListTile(
                title: Text('Log Out', style: TextStyle(fontSize: 16, color: Colors.red)),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
                leading: Icon(Icons.logout, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
      body: DriverMap(),
    );
  }
}

class DriverMap extends StatefulWidget {
  const DriverMap({super.key});

  @override
  _DriverMapState createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};
  StreamSubscription<Position>? _positionStream;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _error = "Location services are disabled.";
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _error = "Location permissions are denied.";
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _error = "Location permissions are permanently denied.";
          _isLoading = false;
        });
        return;
      }

      _positionStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position position) async {
        LatLng pos = LatLng(position.latitude, position.longitude);

        await _sendLocationToFirestore(pos);

        setState(() {
          _currentPosition = pos;
          _markers.clear();
          _markers.add(
            Marker(
              markerId: MarkerId('driverLocation'),
              position: _currentPosition!,
              infoWindow: InfoWindow(title: "Driver Location"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            ),
          );
          _isLoading = false;
        });

        // Move camera to new position
        final GoogleMapController mapController = await _controller.future;
        mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
      });
    } catch (e) {
      setState(() {
        _error = "Error getting location: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _sendLocationToFirestore(LatLng pos) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      await FirebaseFirestore.instance
          .collection('UserLocation')
          .doc(userId)
          .set({
        'Location': GeoPoint(pos.latitude, pos.longitude),
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating Firestore location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!, style: TextStyle(color: Colors.red, fontSize: 16)));
    }

    if (_currentPosition == null) {
      return Center(
          child: Text("Waiting for location...", style: TextStyle(fontSize: 16)));
    }

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition!,
            zoom: 15,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          zoomGesturesEnabled: true,
          compassEnabled: true,
        ),
        Positioned(
          top: 16,
          right: 16,
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              if (_currentPosition != null) {
                controller.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
              }
            },
            child: Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
