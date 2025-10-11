import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonDetailScreen extends StatelessWidget {
  final Map<String, dynamic> lesson;
  final int subjectIndex;
  final int lessonIndex;

  const LessonDetailScreen({
    super.key, // Correction: Utilisation de Key? au lieu de super.key
    required this.lesson,
    required this.subjectIndex,
    required this.lessonIndex,
  }); // Ajout de l'appel au constructeur parent

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {
        'name': 'العربية',
        'icon': Icons.language,
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'مقدمة في اللغة العربية',
            'content_type': 'text',
            'content': 'وثراءً، مما جعلها تصنف عالمياً كواحدة من اللغات التي يسعى كثير من الناس إلى تعلمها وتعليمها...'
          },
          {
            'title': 'Leçon 2',
            'description': 'الحروف العربية',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=DB-wFbnA0sQ'
          },
          {
            'title': 'Leçon 3',
            'description': 'قواعد اللغة العربية',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=AyAwpMeL4zI'
          },
        ],
      },
      {
        'name': 'Français',
        'icon': Icons.book,
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'Les bases du français',
            'content_type': 'text',
            'content': 'La grammaire française fait toujours un peu peur aux étudiants… Beaucoup pensent qu\'il n\'est pas nécessaire de l\'étudier...'
          },
          {
            'title': 'Leçon 2',
            'description': 'Les conjugaisons',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=Lvs2OvBKSGU'
          },
          {
            'title': 'Leçon 3',
            'description': 'La grammaire française',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=ZfHxE3aLlpI'
          },
        ],
      },
      {
        'name': 'Mathématiques',
        'icon': Icons.calculate,
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'Les nombres premiers',
            'content_type': 'text',
            'content': 'Un nombre premier est un entier naturel qui admet exactement deux diviseurs distincts entiers et positifs...'
          },
          {
            'title': 'Leçon 2',
            'description': 'Les fractions',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=0-y8RUNPnQE'
          },
          {
            'title': 'Leçon 3',
            'description': 'Les équations linéaires',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=0uYJ3RNL5SU&list=PL024XGD7WCIFSxatDf77naZwvNPiPbAe4'
          },
        ],
      },
      {
        'name': 'Sciences',
        'icon': Icons.science,
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'Les lois de Newton',
            'content_type': 'text',
            'content': 'Les lois du mouvement de Newton sont un ensemble qui constituent la base de la théorie de Newton sur le mouvement des corps...'
          },
          {
            'title': 'Leçon 2',
            'description': 'Les atomes et molécules',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=ZWfJPBoApJ8'
          },
          {
            'title': 'Leçon 3',
            'description': 'Les phénomènes thermiques',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=M_heg5d4ofw'
          },
        ],
      },
      {
        'name': 'Anglais',
        'icon': Icons.language,
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'Les bases de la grammaire anglaise',
            'content_type': 'text',
            'content': 'English grammar is the set of rules that describe how words and phrases are used in the English language...'
          },
          {
            'title': 'Leçon 2',
            'description': 'Irregular verbs',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=MA3NFtLc22k'
          },
          {
            'title': 'Leçon 3',
            'description': 'Common expressions in English',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=bj5btO2nvt8'
          },
        ],
      },
      {
        'name': 'Histoire',
        'icon': Icons.history,
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'الثورة التونسية',
            'content_type': 'text',
            'content': 'الثورة التونسية (والتي تعرف أيضًا بثورة الحرية والكرامة...)'
          },
          {
            'title': 'Leçon 2',
            'description': 'الحضارات القديمة العظيمة',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=A9bK5KNwVyE'
          },
          {
            'title': 'Leçon 3',
            'description': 'الحرب العالمية الأولى',
            'content_type': 'video',
            'content': 'https://www.youtube.com/watch?v=1yWFzqz1KJU'
          },
        ],
      },
    ];

    final currentSubject = subjects[subjectIndex];
    final List<dynamic> lessonList = currentSubject['content'] as List<dynamic>; // Ajout du type explicite

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson['title']),
        backgroundColor: Colors.orange[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson['description'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            if (lesson['content_type'] == 'text') ...[
              Text(
                lesson['content'],
                style: const TextStyle(fontSize: 16),
              ),
            ] else if (lesson['content_type'] == 'video') ...[
              ElevatedButton(
                onPressed: () {
                  _launchURL(lesson['content'] as String, context); // Ajout du cast en String
                },
                child: const Text('Regarder la vidéo'), // Ajout de const
              ),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (lessonIndex > 0) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonDetailScreen(
                            lesson: lessonList[lessonIndex - 1] as Map<String, dynamic>, // Ajout du cast
                            subjectIndex: subjectIndex,
                            lessonIndex: lessonIndex - 1,
                          ),
                        ),
                      );
                    },
                    child: const Text('Leçon précédente'), // Ajout de const
                  ),
                ],
                if (lessonIndex < lessonList.length - 1) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonDetailScreen(
                            lesson: lessonList[lessonIndex + 1] as Map<String, dynamic>, // Ajout du cast
                            subjectIndex: subjectIndex,
                            lessonIndex: lessonIndex + 1,
                          ),
                        ),
                      );
                    },
                    child: const Text('Leçon suivante'), // Ajout de const
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url, BuildContext context) async { // Ajout du type de retour
    try {
      if (await canLaunchUrl(Uri.parse(url))) { // Mise à jour pour url_launcher 6.0.0+
        await launchUrl(Uri.parse(url)); // Mise à jour pour url_launcher 6.0.0+
      } else {
        _showErrorMessage(context, 'Impossible d\'ouvrir ce lien');
      }
    } catch (e) {
      _showErrorMessage(context, 'Une erreur s\'est produite : $e');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}