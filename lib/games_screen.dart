import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeux et Quiz'),
        backgroundColor: Colors.orange[700],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/jeu.jpg"), // Chemin de votre image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Section Jeux et Quiz',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.gamepad, size: 40, color: Colors.orange[800]),
                  title: const Text(
                    'Jeu de Mémoire',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MemoryGame()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.quiz, size: 40, color: Colors.orange[800]),
                  title: const Text(
                    'Quiz Culture Générale',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizGame()),
                    );
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

// Jeu de mémoire
class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<String> cards = [
    'A', 'A', 'B', 'B', 'C', 'C', 'D', 'D', 'E', 'E', 'F', 'F'
  ];
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
          
          if (pairsFound == cards.length ~/ 2) {
            _showWinDialog();
          }
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Félicitations !'),
          content: const Text('Vous avez trouvé toutes les paires !'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  cards.shuffle();
                  cardFlips = List<bool>.filled(cards.length, false);
                  pairsFound = 0;
                });
              },
              child: const Text('Rejouer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Retour'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu de Mémoire'),
        backgroundColor: Colors.orange[700],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"), // Même image ou différente
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.9,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => flipCard(index),
              child: Card(
                color: cardFlips[index] ? Colors.orange[100] : Colors.orange[700],
                elevation: 4,
                child: Center(
                  child: Text(
                    cardFlips[index] ? cards[index] : '?',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: cardFlips[index] ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Jeu de quiz
class QuizGame extends StatefulWidget {
  const QuizGame({super.key});

  @override
  _QuizGameState createState() => _QuizGameState();
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

  void answerQuestion(int answerIndex) {
    if (answered) return;

    setState(() {
      answered = true;
      if (answerIndex == questions[currentQuestionIndex]['correctIndex']) {
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Résultats du Quiz'),
          content: Text('Votre score: $score/${questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  answered = false;
                });
              },
              child: const Text('Recommencer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Retour'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Culture Générale'),
        backgroundColor: Colors.orange[700],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"), // Même image ou différente
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / questions.length,
                backgroundColor: Colors.grey[300],
                color: Colors.orange,
              ),
              const SizedBox(height: 30),
              Text(
                questions[currentQuestionIndex]['question'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ...List.generate(4, (index) {
                bool isCorrect = index == questions[currentQuestionIndex]['correctIndex'];
                bool isSelected = answered && index == questions[currentQuestionIndex]['correctIndex'];
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: answered
                          ? isCorrect
                              ? Colors.green
                              : Colors.red
                          : Colors.orange[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => answerQuestion(index),
                    child: Text(questions[currentQuestionIndex]['answers'][index]),
                  ),
                );
              }),
              const SizedBox(height: 20),
              if (answered && currentQuestionIndex < questions.length - 1)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentQuestionIndex++;
                      answered = false;
                    });
                  },
                  child: const Text('Question suivante'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}