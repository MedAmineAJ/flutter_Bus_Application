import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:essai_firebase/firebase_options.dart';
import 'package:essai_firebase/home_screen.dart';
import 'package:essai_firebase/dashboard.dart';
import 'package:essai_firebase/signup.dart';
import 'package:essai_firebase/map_screen.dart';
import 'package:essai_firebase/library_screen.dart';
import 'package:essai_firebase/games_screen.dart';
import 'package:essai_firebase/feedback_screen.dart';
import 'package:essai_firebase/meteo_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://rqqaknntfjrbwoxpwsox.supabase.co',     // 🔸 à remplacer
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJxcWFrbm50ZmpyYndveHB3c294Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI3OTkwMTcsImV4cCI6MjA3ODM3NTAxN30.6wSaaz9lE5eVe8GU1s_wf6LQe0PGjfG1ep39z-OrYFQ',                 // 🔸 à remplacer
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kidway App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => HomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/map': (context) => MapScreen(),
        '/library': (context) => LibraryScreen(),
        '/games': (context) => GamesScreen(), 
        '/feedback': (context) => FeedbackScreen(), // Page du feedback
        '/meteo': (context) => MeteoScreen(),
      },
    );
  }
}