import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MeteoScreen extends StatefulWidget {
  const MeteoScreen({super.key});

  @override
  State<MeteoScreen> createState() => _MeteoScreenState();
}

class _MeteoScreenState extends State<MeteoScreen> {
  // 🔹 Variables météo
  double? temperature;
  int? humidity;
  String? description;
  String? city = "Tunis";

  // 🔹 Ta clé API
  final String apiKey = "40bcfe64d396a42dccd24061a558c90b";

  // 🔹 Fonction pour récupérer les données météo
  Future<void> fetchWeather() async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city,tn&appid=$apiKey&units=metric&lang=fr";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          temperature = data["main"]["temp"];
          humidity = data["main"]["humidity"];
          description = data["weather"][0]["description"];
        });
      } else {
        print("⚠️ Erreur API : ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Erreur de connexion : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(); // Charger les données dès l’ouverture
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo'),
        backgroundColor: Colors.orange[700],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/meteo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Météo actuelle',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Bloc météo dynamique
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange[300]!, Colors.orange[700]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: temperature == null
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.wb_sunny,
                                    size: 60, color: Colors.yellow),
                                const SizedBox(width: 10),
                                Text(
                                  description!.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Température: ${temperature?.toStringAsFixed(1)} °C',
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Humidité: $humidity%',
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 30),

                // 🔹 Bouton d’actualisation
                Center(
                  child: ElevatedButton(
                    onPressed: fetchWeather,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700],
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Actualiser',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
