import 'package:flutter/material.dart';
import 'lesson_detail_screen.dart'; // Importer le fichier de contenu détaillé

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des matières avec leurs contenus associés
    final List<Map<String, dynamic>> subjects = [
      {
        'name': 'العربية',
        'icon': Icons.language,
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'مقدمة في اللغة العربية',
            'content_type': 'text', // Type de contenu
            'content': 'وثراءً، مما جعلها تصنف عالمياً كواحدة من اللغات التي يسعى كثير من الناس إلى تعلمها وتعليمها؛ مما جعل منظمة اليونسكو عام 1948م، تعتمد اللغة العربية ثالث لغة رسمية بعد اللغتين الإنجليزية والفرنسية، وفي عام 1960م, تم الاعتراف رسمياً بدور اللغة العربية في جعل المحتوى العالمي أكثر تأثيراً، مما عجل بعقد المؤتمر الأول لليونسكو في اللغة العربية عام 1974م وتم اعتماد اللغة العربية ضمن اللغات العالمية التي تستخدم في المؤتمرات الدولية.تعد لغتنا العربية من أكثر لغات العالم انتشاراً،'
          },
          {
            'title': 'Leçon 2',
            'description': 'الحروف العربية',
            'content_type': 'video', // Type de contenu
            'content': 'https://www.youtube.com/watch?v=DB-wFbnA0sQ' // Lien vidéo
          },
          {
            'title': 'Leçon 3',
            'description': 'قواعد اللغة العربية',
            'content_type': 'video', // Type de contenu
            'content': 'https://www.youtube.com/watch?v=AyAwpMeL4zI' // Lien vers un PDF
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
            'content': 'La grammaire française fait toujours un peu peur aux étudiants… Beaucoup pensent qu’il n’est pas nécessaire de l’étudier de manière structurelle, car apprendre le français c’est avant tout vouloir communiquer, et non connaître des règles par cœur. Il arrive souvent que les étudiants connaissent très bien les règles de bases de grammaire, réalisent les exercices parfaitement mais soient incapables de communiquer.'
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
            'content': 'Un nombre premier est un entier naturel qui admet exactement deux diviseurs distincts entiers et positifs : 1 et le nombre considéré lui-même. Puisque tout nombre a pour diviseurs 1 et lui-même, comme le montre l’égalité n=nx1.'
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
            'content': 'Les lois du mouvement de Newton sont un ensemble qui constituent la base de la théorie de Newton sur le mouvement des corps, appelée mécanique newtonienne ou mécanique classique.'
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
            'content': 'English grammar is the set of rules that describe how words and phrases are used in the English language. Understanding these basic rules helps you speak and write more clearly and correctly.'
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
            'content': 'الثورة التونسية (والتي تعرف أيضًا بثورة الحرية والكرامة أو ثورة 17 ديسمبر أو ثورة 14 جانفي)، هي ثورة شعبية اندلعت أحداثها في ولاية سيدي بوزيد بتاريخ 17 ديسمبر 2010 تضامنًا مع الشاب محمد البوعزيزي'
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bibliothèque'),
        backgroundColor: Colors.orange[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/library.jpg'), // Chemin de l'image
            fit: BoxFit.cover, // L'image couvre tout l'arrière-plan
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(subject['icon'], color: Colors.orange[800]),
                title: Text(
                  subject['name'],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonDetailScreen(
                        lesson: subject['content'][0],
                        subjectIndex: index,
                        lessonIndex: 0, // Passer l'index de la leçon
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
