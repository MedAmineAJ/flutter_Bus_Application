import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des jeux (style inspiré de LibraryScreen)
    final List<Map<String, dynamic>> games = [
      {
        'name': 'Jeu de Mémoire',
        'lottie': 'assets/images/Cognition.json',
        'screen': const MemoryGame(),
      },
      {
        'name': 'Quiz Culture Générale',
        'lottie': 'assets/images/Quiz button.json',
        'screen': const QuizGame(),
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/jeu.jpg'), // même fond que library
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withOpacity(0.85), // effet flou clair
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: SizedBox(
                    height: 70,
                    width: 70,
                    child: Lottie.asset(
                      game['lottie'],
                      repeat: true,
                      animate: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text(
                    game['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEF6C00),
                    ),
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.orange),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => game['screen']),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

//
// 🔹 Jeu de Mémoire
//
class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<String> cards = ['A', 'A', 'B', 'B', 'C', 'C', 'D', 'D'];
  List<bool> cardFlips = [];
  int? firstCardIndex;
  int? secondCardIndex;
  int pairsFound = 0;

  @override
  void initState() {
    super.initState();
    cards.shuffle();
    cardFlips = List<bool>.filled(cards.length, false);
  }

  void flipCard(int index) {
    if (cardFlips[index] || (secondCardIndex != null)) return;

    setState(() {
      cardFlips[index] = true;
      if (firstCardIndex == null) {
        firstCardIndex = index;
      } else {
        secondCardIndex = index;
        if (cards[firstCardIndex!] == cards[secondCardIndex!]) {
          pairsFound++;
          firstCardIndex = null;
          secondCardIndex = null;
          if (pairsFound == cards.length ~/ 2) _showWinDialog();
        } else {
          Future.delayed(const Duration(milliseconds: 700), () {
            setState(() {
              cardFlips[firstCardIndex!] = false;
              cardFlips[secondCardIndex!] = false;
              firstCardIndex = null;
              secondCardIndex = null;
            });
          });
        }
      }
    });
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Félicitations 🎉'),
        content: Lottie.asset('assets/images/Trophy.json', repeat: false, height: 120),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                cards.shuffle();
                cardFlips = List<bool>.filled(cards.length, false);
                pairsFound = 0;
              });
            },
            child: const Text('Rejouer'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jeu de Mémoire"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Lottie.asset('assets/images/Cognition.json', height: 150),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => flipCard(index),
                  child: Card(
                    color: cardFlips[index] ? Colors.orange[100] : Colors.deepOrange,
                    child: Center(
                      child: Text(
                        cardFlips[index] ? cards[index] : "?",
                        style: TextStyle(
                          fontSize: 30,
                          color: cardFlips[index] ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// Jeu de quiz
//
// 🔹 Quiz Culture Générale (corrigé et bien centré)
//
class QuizGame extends StatefulWidget {
  const QuizGame({super.key});

  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Quelle est la capitale de la Tunisie ?',
      'answers': ['Sfax', 'Tunis', 'Sousse', 'Gabès'],
      'correctIndex': 1,
    },
    {
      'question': '2 + 2 x 2 = ?',
      'answers': ['6', '8', '4', '10'],
      'correctIndex': 0,
    },
    {
      'question': 'Quelle est la langue officielle en Tunisie ?',
      'answers': ['Français', 'Arabe', 'Anglais', 'Berbère'],
      'correctIndex': 1,
    },
    {
      'question': 'Quel est le plus grand désert du monde ?',
      'answers': ['Sahara', 'Gobi', 'Antarctique', 'Kalahari'],
      'correctIndex': 2,
    },
  ];

  void answerQuestion(int index) {
    if (answered) return;
    setState(() {
      answered = true;
      if (index == questions[currentQuestionIndex]['correctIndex']) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          answered = false;
        });
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Résultat 🎯', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/images/Quiz button.json', height: 100),
            const SizedBox(height: 10),
            Text('Votre score : $score / ${questions.length}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestionIndex = 0;
                score = 0;
                answered = false;
              });
            },
            child: const Text('Rejouer'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Culture Générale"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/jeu.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset('assets/images/Quiz button.json', height: 120),
                const SizedBox(height: 20),
                Text(
                  "Question ${currentQuestionIndex + 1}/${questions.length}",
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / questions.length,
                  color: Colors.deepOrange,
                  backgroundColor: Colors.orange.shade100,
                ),
                const SizedBox(height: 30),
                Text(
                  question['question'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                // 🟠 Boutons uniformes et centrés
                Expanded(
                  child: ListView.builder(
                    itemCount: question['answers'].length,
                    itemBuilder: (context, i) {
                      bool isCorrect = i == question['correctIndex'];
                      Color buttonColor = Colors.deepOrange;

                      if (answered) {
                        if (isCorrect) {
                          buttonColor = Colors.green;
                        } else {
                          buttonColor = Colors.red.shade400;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () => answerQuestion(i),
                            child: Text(question['answers'][i]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
