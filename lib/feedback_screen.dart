import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Variables pour gérer l'état de la sélection des visages et des étoiles
  int selectedFaceIndex = -1; // -1 signifie aucune sélection
  int selectedStars = 0;
  TextEditingController commentController = TextEditingController();

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

              // Section des icônes de visages (content, fâché, normal) sous forme de boutons
              const Text(
                'Comment vous sentez-vous ?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Visage fâché
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_dissatisfied, size: 40),
                    color: selectedFaceIndex == 0 ? Colors.red : Colors.grey,
                    onPressed: () {
                      setState(() {
                        selectedFaceIndex = 0;
                      });
                    },
                  ),
                  // Visage normal
                  IconButton(
                    icon: const Icon(Icons.sentiment_neutral, size: 40),
                    color: selectedFaceIndex == 1 ? Colors.grey : Colors.grey,
                    onPressed: () {
                      setState(() {
                        selectedFaceIndex = 1;
                      });
                    },
                  ),
                  // Visage content
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_satisfied, size: 40),
                    color: selectedFaceIndex == 2 ? Colors.green : Colors.grey,
                    onPressed: () {
                      setState(() {
                        selectedFaceIndex = 2;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Section des étoiles (notation) sous forme de boutons
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
                    onPressed: () {
                      setState(() {
                        selectedStars = index + 1;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Champ de texte pour commentaires
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

              // Bouton "Soumettre"
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Vérifie si les champs sont remplis
                    if (selectedFaceIndex == -1 || selectedStars == 0 || commentController.text.isEmpty) {
                      // Affiche un message Toast si les champs ne sont pas remplis
                      Fluttertoast.showToast(
                        msg: "Veuillez remplir tous les champs.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      // Logique pour soumettre le feedback
                      // Navigue vers le Dashboard après soumission
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    backgroundColor: Colors.orange[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
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
