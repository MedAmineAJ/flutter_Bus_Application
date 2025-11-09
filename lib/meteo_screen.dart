import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:ui';

class MeteoScreen extends StatefulWidget {
  const MeteoScreen({super.key});

  @override
  State<MeteoScreen> createState() => _MeteoScreenState();
}

class _MeteoScreenState extends State<MeteoScreen>
    with SingleTickerProviderStateMixin {
  double? temperature;
  int? humidity;
  String? description;
  String? city = "Kasserine";

  Map<String, Map<String, dynamic>> weatherData = {
    'hier': {'temp': 22.0, 'humidity': 65, 'description': 'Ensoleillé'},
    'aujourd\'hui': {'temp': null, 'humidity': null, 'description': null},
    'demain': {'temp': 25.0, 'humidity': 39, 'description': 'Partiellement nuageux'},
  };

  final String apiKey = "40bcfe64d396a42dccd24061a558c90b";

  final List<String> cities = [
    "Tunis", "Ariana", "Ben Arous", "La Manouba", "Nabeul", "Zaghouan",
    "Bizerte", "Béja", "Jendouba", "Le Kef", "Siliana", "Sousse",
    "Monastir", "Mahdia", "Kairouan", "Sfax", "Gafsa", "Tozeur",
    "Kebili", "Gabes", "Medenine", "Tataouine", "Sidi Bouzid", "Kasserine",
    "Hammamet", "Djerba", "Sidi Bou Saïd", "Tabarka", "Douz", "El Jem"
  ];

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
          weatherData['aujourd\'hui'] = {
            'temp': temperature,
            'humidity': humidity,
            'description': description
          };
        });
      } else {
        _showErrorSnackbar("Impossible de récupérer les données météo");
      }
    } catch (e) {
      _showErrorSnackbar("Erreur de connexion");
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  // Fonction pour retourner le bon fichier Lottie
  String getLottieAnimation(String? desc) {
    if (desc == null) return 'assets/images/sunny.json';
    desc = desc.toLowerCase();
    if (desc.contains('soleil') || desc.contains('clair')) {
      return 'assets/images/sunny.json';
    } else if (desc.contains('nuage') || desc.contains('partiellement')) {
      return 'assets/images/Weather-windy.json';
    } else if (desc.contains('pluie') || desc.contains('orage')) {
      return 'assets/images/Weather-storm.json';
    } else {
      return 'assets/images/sunny.json';
    }
  }

  Widget _buildWeatherIcon(String? desc) {
    return Lottie.asset(
      getLottieAnimation(desc),
      width: 100,
      height: 100,
      fit: BoxFit.contain,
      repeat: true,
      animate: true,
    );
  }

  Widget _buildDayCircle(String day, Map<String, dynamic> data, Color color) {
    final temp = data['temp'];
    final dayHumidity = data['humidity'];

    return Column(
      children: [
        CircularPercentIndicator(
          radius: MediaQuery.of(context).size.width * 0.16,
          lineWidth: 8.0,
          percent: temp != null ? (temp / 40).clamp(0.0, 1.0) : 0,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(day,
                  style: const TextStyle(
                      color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(temp != null ? '${temp.toStringAsFixed(0)}°' : '--',
                  style: const TextStyle(
                      color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(dayHumidity != null ? '$dayHumidity%' : '--',
                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 11)),
            ],
          ),
          progressColor: color,
          backgroundColor: Colors.orange.withOpacity(0.2),
          animation: true,
          animationDuration: 1500,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          child: Text(
            data['description'] ?? '--',
            style: const TextStyle(color: Colors.orange, fontSize: 11),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fond blanc
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header ville + refresh
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: city,
                        dropdownColor: Colors.orange[100],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                        underline: Container(),
                        iconEnabledColor: Colors.orange,
                        isExpanded: true,
                        items: cities
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(color: Colors.orange),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            city = value;
                            fetchWeather();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.orange, size: 22),
                      onPressed: fetchWeather,
                      tooltip: 'Actualiser',
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Carte météo principale
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.orange.withOpacity(0.3), width: 1.5),
                ),
                child: Column(
                  children: [
                    _buildWeatherIcon(description),
                    const SizedBox(height: 20),
                    Text(
                      description != null
                          ? description!.toUpperCase()
                          : 'PEU NUAGEUX',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      temperature != null
                          ? '${temperature?.toStringAsFixed(1)} °C'
                          : '17.4 °C',
                      style: const TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w900,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      humidity != null ? 'Humidité: $humidity%' : 'Humidité: 49%',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Prévisions 3 jours
              const Text(
                'Prévisions sur 3 jours',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDayCircle('Hier', weatherData['hier']!, Colors.orangeAccent),
                  _buildDayCircle('Aujourd\'hui', weatherData['aujourd\'hui']!, Colors.deepOrangeAccent),
                ],
              ),
              const SizedBox(height: 25),
              _buildDayCircle('Demain', weatherData['demain']!, Colors.orange),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
