import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_database/firebase_database.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? latitude;
  double? longitude;
  final MapController mapController = MapController();

  late DatabaseReference ref;
  bool _running = true;

  @override
  void initState() {
    super.initState();

    final database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL:
          "https://finalkidway-default-rtdb.europe-west1.firebasedatabase.app/",
    );
    ref = database.ref('coordinates');

    // Démarrer la boucle périodique
    updateRandomCoordinates();
    periodicFetchCoordinates();
  }

  @override
  void dispose() {
    _running = false; // stoppe la boucle
    super.dispose();
  }

  Future<void> updateRandomCoordinates() async {
    final random = Random();
    double baseLat = 36.8065;
    double baseLon = 10.1815;

    double newLat = baseLat + (random.nextDouble() - 0.5) / 100;
    double newLon = baseLon + (random.nextDouble() - 0.5) / 100;

    try {
      await ref.set({
        'latitude': newLat,
        'longitude': newLon,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print("Erreur en écrivant dans Firebase : $e");
    }
  }

  Future<void> fetchCoordinates() async {
    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        if (!mounted) return;
        setState(() {
          latitude = (data['latitude'] as num).toDouble();
          longitude = (data['longitude'] as num).toDouble();
        });
        mapController.move(LatLng(latitude!, longitude!), 13.0);
      }
    } catch (e) {
      print("Erreur Firebase : $e");
    }
  }

  Future<void> periodicFetchCoordinates() async {
    while (_running) {
      try {
        await updateRandomCoordinates();
        await fetchCoordinates();
      } catch (e) {
        print("Erreur dans la boucle périodique : $e");
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return latitude == null || longitude == null
        ? const Center(child: CircularProgressIndicator())
        : FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: LatLng(latitude!, longitude!),
              initialZoom: 13.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.example.essai_firebase",
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(latitude!, longitude!),
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.location_pin,
                      size: 39,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
