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

  late DatabaseReference dbRef;
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    final database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL: "https://finalkidway-default-rtdb.europe-west1.firebasedatabase.app/",
    );
    dbRef = database.ref('feedback');
  }

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

      commentController.clear();
      setState(() {
        selectedFaceIndex = -1;
        selectedStars = 0;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erreur lors de l’envoi.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() => isSending = false);
    }
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange[700],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.feedback, size: 50, color: Colors.white, shadows: [
            Shadow(
              blurRadius: 8,
              color: Colors.white.withOpacity(0.8),
              offset: const Offset(0, 0),
            ),
          ]),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "Nous apprécions vos retours !",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFaceSelection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const Text(
              "Comment vous sentez-vous ?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFaceIcon(Icons.sentiment_very_dissatisfied, 0, Colors.red),
                buildFaceIcon(Icons.sentiment_neutral, 1, Colors.amber),
                buildFaceIcon(Icons.sentiment_very_satisfied, 2, Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFaceIcon(IconData icon, int index, Color color) {
    bool selected = selectedFaceIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedFaceIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? color.withOpacity(0.3) : Colors.grey[200],
          boxShadow: selected
              ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 4))]
              : [],
        ),
        child: Icon(
          icon,
          size: 50,
          color: selected ? color : Colors.grey[500],
        ),
      ),
    );
  }

  Widget buildStarRating() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const Text(
              "Veuillez évaluer votre expérience",
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
                    color: index < selectedStars ? Colors.orange : Colors.grey[300],
                  ),
                  onPressed: () => setState(() => selectedStars = index + 1),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCommentField() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Votre suggestion ou commentaire",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Écrivez ici...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: isSending ? null : sendFeedback,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[700],
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
        ),
        child: isSending
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Soumettre",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildHeader(),
              const SizedBox(height: 25),
              buildFaceSelection(),
              const SizedBox(height: 20),
              buildStarRating(),
              const SizedBox(height: 20),
              buildCommentField(),
              const SizedBox(height: 30),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
