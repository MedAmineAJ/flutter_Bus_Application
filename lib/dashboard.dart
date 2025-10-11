import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        backgroundColor: Colors.orange[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bus1.jpg"), // Chemin de votre image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // 🔸 Grand titre d'accueil avec icône de bus
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: const [
                    Icon(
                      Icons.directions_bus_filled,
                      size: 60,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Bienvenue dans le tableau de bord Kidway',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 🔸 Carte pour Voir la carte
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.map, size: 40, color: Colors.orange[800]),
                  title: const Text(
                    'Voir la carte',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(context, '/map');
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 🔸 Carte pour Voir la bibliothèque
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.library_books, size: 40, color: Colors.orange[800]),
                  title: const Text(
                    'Voir la bibliothèque',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(context, '/library');
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 🔸 Carte pour Voir les Jeux
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.gamepad, size: 40, color: Colors.orange[800]),
                  title: const Text(
                    'Voir les jeux',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(context, '/games');
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 🔸 Carte pour Voir la Météo
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.wb_sunny, size: 40, color: Colors.orange[800]),
                  title: const Text(
                    'Voir la météo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(context, '/meteo');  // Nouvelle route vers la météo
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 🔸 Carte pour Voir le Feedback
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.feedback, size: 40, color: Colors.orange[800]),
                  title: const Text(
                    'Feedback et Suggestions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(context, '/feedback');  // Nouvelle route vers le feedback
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}