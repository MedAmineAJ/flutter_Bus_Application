import 'package:flutter/material.dart';

class MeteoScreen extends StatelessWidget {
  const MeteoScreen({super.key});

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
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/meteo.jpg', // Assurez-vous de mettre le bon chemin de l'image
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

                // Conteneur avec une décoration soignée
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
                        offset: Offset(0, 3), // décalage de l'ombre
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            size: 60,
                            color: Colors.yellow[700],
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Ensoleillé',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Température: 25°C',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Humidité: 70%',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Conditions: Ensoleillé',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Bouton d'actualisation avec une belle apparence
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Action à prendre, par exemple pour actualiser la météo
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700],
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
