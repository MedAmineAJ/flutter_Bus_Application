import 'package:flutter/material.dart';

class LessonDetailScreen extends StatelessWidget {
  final Map<String, dynamic> lesson;
  final int subjectIndex;
  final int lessonIndex;

  const LessonDetailScreen({
    super.key,
    required this.lesson,
    required this.subjectIndex,
    required this.lessonIndex,
  });

  @override
  Widget build(BuildContext context) {
    // 🧠 Liste des matières et leçons (tout en texte)
    final subjects = [
      // Arabe
      {
        'name': 'العربية',
        'icon': Icons.language,
        'content': [
          {
            'title': 'مقدمة في اللغة العربية',
            'description': 'تعرف على جمال لغتنا العربية وأهميتها في الثقافة والتاريخ.',
            'content_type': 'text',
            'content': '''
اللغة العربية هي واحدة من أقدم اللغات السامية وأكثرها استخدامًا في العالم. 
تتميز ببنيتها الغنية ومفرداتها الواسعة التي تسمح بالتعبير الدقيق والعميق عن الأفكار والمشاعر.

📚 تعتبر اللغة العربية لغة القرآن الكريم، وهذا ما يمنحها مكانة عظيمة في قلوب المتحدثين بها. 
لقد كانت وسيلة لنقل العلوم والفنون والفكر الإنساني عبر القرون.

🌍 اليوم، يتحدث بالعربية أكثر من 400 مليون شخص حول العالم، وهي لغة رسمية في أكثر من 20 دولة.
          '''
          },
          {
            'title': 'الحروف العربية',
            'description': 'تعلم الحروف العربية بطريقة سهلة وممتعة.',
            'content_type': 'text',
            'content': '''
تتألف الحروف العربية من 28 حرفًا تبدأ بحرف الألف وتنتهي بحرف الياء.
كل حرف يمكن أن يتصل بما يسبقه أو يتبعه في الكلمة، مما يعطي الكتابة العربية شكلًا فنيًا مميزًا.

🔤 أمثلة على الحروف:
أ، ب، ت، ث، ج، ح، خ... وهكذا.

✍️ تتميز الحروف العربية بأنها تكتب من اليمين إلى اليسار، وتُستخدم في العديد من اللغات مثل الفارسية والأردية.
          '''
          },
          {
            'title': 'قواعد اللغة العربية',
            'description': 'أساسيات النحو والصرف بطريقة بسيطة وواضحة.',
            'content_type': 'text',
            'content': '''
قواعد اللغة العربية تُعرف باسم "النحو" و"الصرف"، وهي التي تنظّم كيفية تكوين الجمل والكلمات.

🔹 **النحو**: يهتم بتركيب الجمل وتحديد مواقع الكلمات فيها (فاعل، مفعول به، مبتدأ، خبر...).
🔹 **الصرف**: يهتم ببنية الكلمة وتحولاتها (مثل كتبَ – يكتبُ – كتابةً).

🧩 تعلم القواعد يساعد على كتابة صحيحة وفهم أعمق للنصوص العربية.
          '''
          },
        ],
      },

      // Français
      {
        'name': 'Français',
        'icon': Icons.book,
        'content': [
          {
            'title': 'Les bases du français',
            'description': 'Introduction complète à la langue française et à sa structure.',
            'content_type': 'text',
            'content': '''
Le français est une langue romane issue du latin, parlée dans plus de 30 pays à travers le monde. 
Elle est reconnue pour sa richesse grammaticale et sa précision lexicale.

📘 Les bases du français comprennent la connaissance des articles, des noms, des adjectifs et des verbes.
💬 Exemple : *Le chat noir dort sur la chaise.*

🧠 Apprendre le français, c’est aussi découvrir une culture, une littérature et une manière de penser unique.
          '''
          },
          {
            'title': 'Les conjugaisons',
            'description': 'Maîtrise des temps et des formes verbales.',
            'content_type': 'text',
            'content': '''
La conjugaison française repose sur trois groupes de verbes : 
- **1er groupe** : verbes en -er (parler, aimer)
- **2e groupe** : verbes en -ir (finir, grandir)
- **3e groupe** : verbes irréguliers (aller, venir, prendre)

🕒 Les temps les plus utilisés sont :
- Le présent → *Je parle*
- Le passé composé → *J’ai parlé*
- Le futur → *Je parlerai*

✨ Une bonne maîtrise de la conjugaison permet d’exprimer clairement ses idées dans le temps.
          '''
          },
          {
            'title': 'La grammaire française',
            'description': 'Découvre les règles essentielles de la langue française.',
            'content_type': 'text',
            'content': '''
La grammaire française organise la structure de la phrase.
Chaque mot a une fonction : sujet, verbe, complément, adjectif, adverbe, etc.

📗 Exemple :
> *Le petit garçon mange une pomme.*
→ “Le petit garçon” est le sujet, “mange” est le verbe, “une pomme” est le complément d’objet.

🌸 La grammaire rend la communication claire et harmonieuse.
          '''
          },
        ],
      },

      // Mathématiques
      {
        'name': 'Mathématiques',
        'icon': Icons.calculate,
        'content': [
          {
            'title': 'Les nombres premiers',
            'description': 'Comprendre ce que sont les nombres premiers et leur importance.',
            'content_type': 'text',
            'content': '''
Un **nombre premier** est un entier naturel supérieur à 1 qui n’a que deux diviseurs : 1 et lui-même.

🔹 Exemples : 2, 3, 5, 7, 11, 13, 17…

Les nombres premiers sont essentiels en mathématiques, notamment dans la cryptographie et la recherche scientifique.
          '''
          },
          {
            'title': 'Les fractions',
            'description': 'Apprends à manipuler et comprendre les fractions.',
            'content_type': 'text',
            'content': '''
Une **fraction** représente une partie d’un tout. 
Elle s’écrit sous la forme a/b, où :
- **a** est le numérateur (parties prises)
- **b** est le dénominateur (parties totales)

📘 Exemple :
> 1/2 signifie “une moitié”.

Les fractions permettent de mesurer, comparer et partager équitablement.
          '''
          },
          {
            'title': 'Les équations linéaires',
            'description': 'Découvre les bases pour résoudre des équations simples.',
            'content_type': 'text',
            'content': '''
Une **équation linéaire** est une expression contenant une inconnue, généralement représentée par x.

📗 Exemple :
> 2x + 3 = 7  
> ⇒ 2x = 4  
> ⇒ x = 2

🧮 Résoudre une équation, c’est trouver la valeur de x qui rend l’égalité vraie.
          '''
          },
        ],
      },

      // Sciences
      {
        'name': 'Sciences',
        'icon': Icons.science,
        'content': [
          {
            'title': 'Les lois de Newton',
            'description': 'Comprendre les principes fondamentaux du mouvement.',
            'content_type': 'text',
            'content': '''
Les lois du mouvement de Newton expliquent comment les objets se déplacent sous l'effet des forces appliquées.
Ces lois sont la base de la mécanique classique et permettent de prédire les mouvements avec précision.

🔹 Première loi : Un corps au repos reste au repos, et un corps en mouvement continue de se déplacer uniformément sauf si une force extérieure agit sur lui.
🔹 Deuxième loi : La force exercée sur un objet est égale à sa masse multipliée par son accélération (F=ma).
🔹 Troisième loi : À toute action correspond une réaction égale et opposée.

Ces principes sont essentiels dans l'ingénierie, la physique et même la vie quotidienne.
          '''
          },
          {
            'title': 'Les atomes et molécules',
            'description': 'Introduction aux constituants fondamentaux de la matière.',
            'content_type': 'text',
            'content': '''
Tout dans l'univers est composé d'**atomes**, qui s'associent pour former des **molécules**.
Les atomes contiennent des protons, des neutrons et des électrons, et leur arrangement détermine les propriétés chimiques des substances.

💡 Les molécules forment tout ce que nous voyons autour de nous : l'eau, l'air, le bois, les métaux...
Comprendre les atomes et molécules permet de mieux saisir les réactions chimiques et les transformations de la matière.
          '''
          },
          {
            'title': 'Les phénomènes thermiques',
            'description': 'Découvre les bases de la chaleur et de l’énergie.',
            'content_type': 'text',
            'content': '''
La **thermodynamique** étudie les échanges d'énergie et de chaleur entre les corps.
La chaleur se transmet par conduction, convection ou rayonnement et peut provoquer des changements d'état comme la fusion ou l'évaporation.

🌡 Comprendre les phénomènes thermiques est crucial pour la science, l'industrie et la vie quotidienne.
          '''
          },
        ],
      },

      // Anglais
      {
        'name': 'Anglais',
        'icon': Icons.language,
        'content': [
          {
            'title': 'Les bases de la grammaire anglaise',
            'description': 'Introduction à la structure de l’anglais.',
            'content_type': 'text',
            'content': '''
English grammar is the set of rules describing how words and phrases are used in the English language.
It covers sentence structure, tenses, articles, prepositions, and punctuation.

📘 Understanding grammar helps in speaking and writing English correctly and fluently.
💡 Example: *The cat sits on the chair.* (“The cat” = subject, “sits” = verb, “on the chair” = prepositional phrase)
          '''
          },
          {
            'title': 'Irregular verbs',
            'description': 'Apprendre les formes irrégulières des verbes en anglais.',
            'content_type': 'text',
            'content': '''
Some verbs in English do not follow regular conjugation patterns. 
Examples include: **go → went**, **be → was/were**, **have → had**.

📖 Memorizing these irregular verbs is essential for correct usage in past and perfect tenses.
          '''
          },
          {
            'title': 'Common expressions in English',
            'description': 'Comprendre les expressions quotidiennes en anglais.',
            'content_type': 'text',
            'content': '''
English is rich with common expressions that help convey ideas naturally. 
Examples: *Break a leg* (good luck), *Hit the books* (study hard), *Piece of cake* (easy task).

💡 Knowing these expressions enhances communication and understanding of English-speaking cultures.
          '''
          },
        ],
      },

      // Histoire
      {
        'name': 'Histoire',
        'icon': Icons.history,
        'content': [
          {
            'title': 'La Révolution tunisienne',
            'description': 'Comprendre les causes et les impacts de la révolution.',
            'content_type': 'text',
            'content': '''
La Révolution tunisienne, survenue en 2010-2011, a marqué le début du Printemps arabe.
Elle a été déclenchée par la lutte contre la corruption, le chômage et l’injustice sociale.

🌟 Cette révolution a conduit à des réformes politiques majeures et à la promotion des droits civiques.
          '''
          },
          {
            'title': 'Les grandes civilisations anciennes',
            'description': 'Découvre les civilisations qui ont marqué l’histoire.',
            'content_type': 'text',
            'content': '''
Les civilisations anciennes telles que l’Égypte, la Mésopotamie, la Grèce et Rome ont posé les bases de la culture, de la science et de l’art.
Leurs avancées en écriture, mathématiques et philosophie influencent encore notre monde aujourd’hui.
          '''
          },
          {
            'title': 'La Première Guerre mondiale',
            'description': 'Comprendre les événements et conséquences de la guerre.',
            'content_type': 'text',
            'content': '''
La Première Guerre mondiale (1914-1918) fut un conflit mondial majeur.
Elle a transformé la politique, l’économie et la société de nombreux pays et préparé le terrain pour la Seconde Guerre mondiale.
          '''
          },
        ],
      },
    ];

    final currentSubject = subjects[subjectIndex];
    final List<dynamic> lessonList = currentSubject['content'] as List<dynamic>;

    // 🌟 Design principal
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(lesson['title']),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson['title'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  lesson['description'],
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 1.2),
                const SizedBox(height: 15),
                Text(
                  lesson['content'],
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 30),
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    if (lessonIndex > 0)
      Expanded(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LessonDetailScreen(
                  lesson: lessonList[lessonIndex - 1] as Map<String, dynamic>,
                  subjectIndex: subjectIndex,
                  lessonIndex: lessonIndex - 1,
                ),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text('Leçon précédente'),
        ),
      ),
    if (lessonIndex > 0 && lessonIndex < lessonList.length - 1)
      const SizedBox(width: 10), // espace entre les deux boutons
    if (lessonIndex < lessonList.length - 1)
      Expanded(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LessonDetailScreen(
                  lesson: lessonList[lessonIndex + 1] as Map<String, dynamic>,
                  subjectIndex: subjectIndex,
                  lessonIndex: lessonIndex + 1,
                ),
              ),
            );
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Leçon suivante'),
        ),
      ),
  ],
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
