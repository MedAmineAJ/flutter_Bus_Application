import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int selectedFaceIndex = -1;
  int selectedStars = 0;
  TextEditingController commentController = TextEditingController();

  late DatabaseReference dbRef; // 🔥 Référence dynamique Firebase
  bool isSending = false;

  @override
  void initState() {
    super.initState();

    // 🔹 Connexion explicite à la base avec ton URL
    final database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL: "https://finalkidway-default-rtdb.europe-west1.firebasedatabase.app/",
    );

    // 🔹 Référence au nœud "feedback"
    dbRef = database.ref('feedback');

    print("✅ Firebase connecté : ${dbRef.path}");
  }

  /// 🔹 Fonction d’envoi vers Firebase
  Future<void> sendFeedback() async {
    if (selectedFaceIndex == -1 || selectedStars == 0 || commentController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Veuillez remplir tous les champs.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() => isSending = true);

    try {
      await dbRef.push().set({
        "face": selectedFaceIndex == 0
            ? "fâché"
            : selectedFaceIndex == 1
                ? "neutre"
                : "satisfait",
        "stars": selectedStars,
        "comment": commentController.text,
        "timestamp": DateTime.now().toIso8601String(),
      });

      Fluttertoast.showToast(
        msg: "✅ Merci pour votre retour !",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      print("📤 Feedback envoyé à Firebase !");
      commentController.clear();
      setState(() {
        selectedFaceIndex = -1;
        selectedStars = 0;
      });
    } catch (e) {
      print("❌ Erreur Firebase : $e");
      Fluttertoast.showToast(
        msg: "Erreur lors de l’envoi.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() => isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback et Suggestions'),
        backgroundColor: Colors.orange[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nous apprécions vos retours !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 🔸 Choix de l’humeur
              const Text(
                'Comment vous sentez-vous ?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_dissatisfied, size: 40),
                    color: selectedFaceIndex == 0 ? Colors.red : Colors.grey,
                    onPressed: () => setState(() => selectedFaceIndex = 0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.sentiment_neutral, size: 40),
                    color: selectedFaceIndex == 1 ? Colors.amber : Colors.grey,
                    onPressed: () => setState(() => selectedFaceIndex = 1),
                  ),
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_satisfied, size: 40),
                    color: selectedFaceIndex == 2 ? Colors.green : Colors.grey,
                    onPressed: () => setState(() => selectedFaceIndex = 2),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🔸 Évaluation par étoiles
              const Text(
                'Veuillez évaluer votre expérience',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      size: 40,
                      color: index < selectedStars ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () => setState(() => selectedStars = index + 1),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // 🔸 Champ commentaire
              const Text(
                'Votre suggestion ou commentaire',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: 'Écrivez ici...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),

              // 🔸 Bouton d’envoi
              Center(
                child: ElevatedButton(
                  onPressed: isSending ? null : sendFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isSending
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Soumettre',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
