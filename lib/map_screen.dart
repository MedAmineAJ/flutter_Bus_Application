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
  bool _running = true; // pour arrêter proprement la boucle si l'écran est détruit

  @override
  void initState() {
    super.initState();

    final database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL:
          "https://finalkidway-default-rtdb.europe-west1.firebasedatabase.app/",
    );
    ref = database.ref('coordinates');

    // Lance le cycle (on n'attend pas ici)
    updateRandomCoordinates();
    periodicFetchCoordinates();
  }

  @override
  void dispose() {
    _running = false; // stoppe la boucle
    super.dispose();
  }

  /// 🔹 Génère des coordonnées aléatoires proches d’une position de référence
  Future<void> updateRandomCoordinates() async {
    final random = Random();

    // Position de référence (Tunis ici par ex)
    double baseLat = 36.8065;
    double baseLon = 10.1815;

    // Variation aléatoire autour de la base
    double newLat = baseLat + (random.nextDouble() - 0.5) / 100;
    double newLon = baseLon + (random.nextDouble() - 0.5) / 100;

    try {
      await ref.set({
        'latitude': newLat,
        'longitude': newLon,
        'timestamp': DateTime.now().toIso8601String(),
      });

      print("📤 Coordonnées envoyées à Firebase : $newLat, $newLon");
    } catch (e) {
      print("❌ Erreur en écrivant dans Firebase : $e");
    }
  }

  /// 🔹 Lit les coordonnées actuelles depuis Firebase
  Future<void> fetchCoordinates() async {
    try {
      final snapshot = await ref.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        print("✅ Coordonnées récupérées : $data");

        if (!mounted) return;
        setState(() {
          latitude = (data['latitude'] as num).toDouble();
          longitude = (data['longitude'] as num).toDouble();
        });

        mapController.move(LatLng(latitude!, longitude!), 13.0);
      } else {
        print("⚠️ Aucune donnée trouvée dans Firebase.");
      }
    } catch (e) {
      print("❌ Erreur Firebase : $e");
    }
  }

  /// 🔹 Met à jour les coordonnées toutes les 5 secondes
  Future<void> periodicFetchCoordinates() async {
    while (_running) {
      try {
        await updateRandomCoordinates(); // Envoie des nouvelles coordonnées
        await fetchCoordinates(); // Lis et affiche
      } catch (e) {
        print("Erreur dans la boucle périodique : $e");
      }

      // Attendre 5 secondes (si _running devient false, on sort au prochain tour)
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Position dynamique Firebase")),
      body: latitude == null || longitude == null
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
            ),
    );
  }
}
