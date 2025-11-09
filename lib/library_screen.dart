import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'lesson_detail_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des matières avec Lottie et contenu
    final List<Map<String, dynamic>> subjects = [
      {
        'name': 'العربية',
        'lottie': 'assets/images/Arabic.json',
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'مقدمة في اللغة العربية',
            'content_type': 'text',
           'content': 'وثراءً، مما جعلها تصنف عالمياً كواحدة من اللغات التي يسعى كثير من الناس إلى تعلمها وتعليمها؛ مما جعل منظمة اليونسكو عام 1948م، تعتمد اللغة العربية ثالث لغة رسمية بعد اللغتين الإنجليزية والفرنسية، وفي عام 1960م, تم الاعتراف رسمياً بدور اللغة العربية في جعل المحتوى العالمي أكثر تأثيراً، مما عجل بعقد المؤتمر الأول لليونسكو في اللغة العربية عام 1974م وتم اعتماد اللغة العربية ضمن اللغات العالمية التي تستخدم في المؤتمرات الدولية.تعد لغتنا العربية من أكثر لغات العالم انتشاراً،'

          },
        ],
      },
      {
        'name': 'Français',
        'lottie': 'assets/images/France.json',
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'Les bases du français',
            'content_type': 'text',
           'content': 'La grammaire française fait toujours un peu peur aux étudiants… Beaucoup pensent qu’il n’est pas nécessaire de l’étudier de manière structurelle, car apprendre le français c’est avant tout vouloir communiquer, et non connaître des règles par cœur. Il arrive souvent que les étudiants connaissent très bien les règles de bases de grammaire, réalisent les exercices parfaitement mais soient incapables de communiquer.'

          },
        ],
      },
      {
        'name': 'Mathématiques',
        'lottie': 'assets/images/Calculator.json',
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'Les nombres premiers',
            'content_type': 'text',
               'content': 'Un nombre premier est un entier naturel qui admet exactement deux diviseurs distincts entiers et positifs : 1 et le nombre considéré lui-même. Puisque tout nombre a pour diviseurs 1 et lui-même, comme le montre l’égalité n=nx1.'

          },
        ],
      },
      {
        'name': 'Sciences',
        'lottie': 'assets/images/Happy Students Studying.json',
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'Les lois de Newton',
            'content_type': 'text',
              'content': 'Les lois du mouvement de Newton sont un ensemble qui constituent la base de la théorie de Newton sur le mouvement des corps, appelée mécanique newtonienne ou mécanique classique.'

          },
        ],
      },
      {
        'name': 'Anglais',
        'lottie': 'assets/images/British Flag.json',
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'Les bases de la grammaire anglaise',
            'content_type': 'text',
            'content': 'English grammar is the set of rules that describe how words and phrases are used in the English language. Understanding these basic rules helps you speak and write more clearly and correctly.'

          },
        ],
      },
      {
        'name': 'Histoire',
        'lottie': 'assets/images/History.json',
        'content': [
          {
            'title': 'Leçon 1',
            'description': 'الثورة التونسية',
            'content_type': 'text',
            'content': 'الثورة التونسية (والتي تعرف أيضًا بثورة الحرية والكرامة أو ثورة 17 ديسمبر أو ثورة 14 جانفي)، هي ثورة شعبية اندلعت أحداثها في ولاية سيدي بوزيد بتاريخ 17 ديسمبر 2010 تضامنًا مع الشاب محمد البوعزيزي'

          },
        ],
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/library.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withOpacity(0.85), // légère couche blanche transparente
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
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
                      subject['lottie'],
                      repeat: true,
                      animate: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text(
                    subject['name'],
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
                      MaterialPageRoute(
                        builder: (context) => LessonDetailScreen(
                          lesson: subject['content'][0],
                          subjectIndex: index,
                          lessonIndex: 0,
                        ),
                      ),
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
