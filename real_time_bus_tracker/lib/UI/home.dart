import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import './login.dart';
import 'dart:async';

FirebaseFirestore db = FirebaseFirestore.instance;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🚍 Bus Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
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
                          "Welcome",
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
                  await handleSignOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
                leading: Icon(Icons.logout, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 50,
            left: 0,
            right: 0,
            child: MapView(),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.75,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Center(
                  child: DropDown(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<int>(
        value: dropdownValue,
        decoration: InputDecoration(
          labelText: "Select Route",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple, fontSize: 16),
        onChanged: (int? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text("Route $value"),
          );
        }).toList(),
      ),
    );
  }
}

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _initialPosition;
  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;
  Timer? _driverLocationTimer;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _startDriverLocationUpdates();
  }

  @override
  void dispose() {
    _driverLocationTimer?.cancel();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
      );

      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        print('User location: ${placemarks[0].name}');
      });
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  void _startDriverLocationUpdates() {
    _driverLocationTimer = Timer.periodic(Duration(seconds: 5), (_) {
      _getDriverLocation();
    });
  }

  Future<void> _getDriverLocation() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await db
          .collection('UserLocation')
          .doc('U6PG3P3oChRJHr03xoVLKJjRLF83')
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        GeoPoint geoPoint = snapshot.data()!['Location'];
        LatLng pos = LatLng(geoPoint.latitude, geoPoint.longitude);
        print('Driver position: $pos');

        _setDriverMarker(pos);
      }
    } catch (e) {
      print('Error getting driver location: $e');
    }
  }

  void _setDriverMarker(LatLng point) async {
    final String markerIdVal = 'driver_marker';

    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == markerIdVal);

      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
          infoWindow: InfoWindow(title: "Driver Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });

    final GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newLatLng(point));
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initialPosition == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        GoogleMap(
          mapType: _currentMapType,
          initialCameraPosition: CameraPosition(
            target: _initialPosition!,
            zoom: 14.5,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: _markers,
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true,
          compassEnabled: true,
        ),
        Positioned(
          top: 16,
          right: 16,
          child: FloatingActionButton(
            heroTag: "mapTypeBtn",
            backgroundColor: Colors.deepPurple,
            onPressed: _toggleMapType,
            child: Icon(Icons.layers),
          ),
        ),
      ],
    );
  }
}
