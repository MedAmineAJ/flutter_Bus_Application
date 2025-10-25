import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? latitude;
  double? longitude;
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    fetchCoordinates();
    periodicFetchCoordinates();
  }

  Future<void> fetchCoordinates() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/coordinates'));
      //final response = await http.get(Uri.parse('http://192.168.43.63:5600/coordinates'));
      


      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          latitude = data['latitude'];
          longitude = data['longitude'];
        });
        mapController.move(LatLng(latitude!, longitude!), 10.0);
      } else {
        print('Erreur de récupération des coordonnées');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  void periodicFetchCoordinates() {
    Future.delayed(Duration(seconds: 5), () {
      fetchCoordinates();
      periodicFetchCoordinates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Position actuelle")),
      body: latitude == null || longitude == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(latitude!, longitude!),
                maxZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.flutter_application_111',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(latitude!, longitude!),
                      width: 40.0,
                      height: 40.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.location_pin, size: 39, color: Colors.red),
                      rotate: false,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}