import 'package:flutter/material.dart';
import 'games_screen.dart';
import 'map_screen.dart';
import 'library_screen.dart';
import 'meteo_screen.dart';
import 'feedback_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Par défaut, afficher "Jeux"
  int _selectedIndex = 2;

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  final List<Widget> _screens = const [
    MapScreen(),
    LibraryScreen(),
    GamesScreen(),
    MeteoScreen(),
    FeedbackScreen(),
  ];

  final List<String> _titles = [
    'Carte',
    'Bibliothèque',
    'Jeux',
    'Météo',
    'Feedback',
  ];

  final List<IconData> _icons = [
    Icons.map_rounded,
    Icons.library_books_rounded,
    Icons.gamepad_rounded,
    Icons.wb_sunny_rounded,
    Icons.feedback_rounded,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Déconnexion'),
        backgroundColor: Colors.deepOrange,
        automaticallyImplyLeading: false, // Supprime le bouton retour
        actions: [
          IconButton(
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Affiche directement l'écran correspondant
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: _icons.asMap().entries.map((entry) {
          int idx = entry.key;
          IconData icon = entry.value;
          return BottomNavigationBarItem(
            icon: Icon(icon),
            label: _titles[idx],
          );
        }).toList(),
      ),
    );
  }
}
