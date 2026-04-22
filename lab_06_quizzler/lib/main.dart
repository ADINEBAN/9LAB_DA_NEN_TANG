import 'package:flutter/material.dart';

void main() {
  runApp(const QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00A896),
          brightness: Brightness.dark,
        ),
      ),
      home: const QuizzlerPage(),
    );
  }
}

class QuizzlerPage extends StatefulWidget {
  const QuizzlerPage({super.key});

  @override
  State<QuizzlerPage> createState() => _QuizzlerPageState();
}

class _QuizzlerPageState extends State<QuizzlerPage> {
  final List<_Question> _questions = const [
    _Question('Flutter is built by Google.', true),
    _Question('A StatefulWidget never changes once rendered.', false),
    _Question('Dart supports async and await.', true),
    _Question('The MaterialApp widget is used only for Android Studio.', false),
    _Question('Hot reload helps speed up UI iteration.', true),
  ];

  final List<bool> _history = [];
  int _questionIndex = 0;
  int _score = 0;

  void _submitAnswer(bool answer) {
    final current = _questions[_questionIndex];
    final isCorrect = current.answer == answer;
    final isLast = _questionIndex == _questions.length - 1;

    setState(() {
      _history.add(isCorrect);
      if (isCorrect) {
        _score++;
      }
      if (!isLast) {
        _questionIndex++;
      }
    });

    if (isLast) {
      _showResultDialog();
    }
  }

  Future<void> _showResultDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF10232A),
          title: const Text('Quiz Complete'),
          content: Text('You scored $_score out of ${_questions.length}.'),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _score = 0;
                  _questionIndex = 0;
                  _history.clear();
                });
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_questionIndex + 1) / _questions.length;
    final currentQuestion = _questions[_questionIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF071B21), Color(0xFF0C3A45), Color(0xFF126E82)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'QUIZZLER',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.4,
                  ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(999),
                  backgroundColor: Colors.white12,
                ),
                const SizedBox(height: 14),
                Text(
                  'Question ${_questionIndex + 1} of ${_questions.length}',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white.withOpacity(0.08),
                    ),
                    child: Center(
                      child: Text(
                        currentQuestion.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF22C55E),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        onPressed: () => _submitAnswer(true),
                        child: const Text(
                          'TRUE',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        onPressed: () => _submitAnswer(false),
                        child: const Text(
                          'FALSE',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _history
                      .map(
                        (isCorrect) => Icon(
                          isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                          color: isCorrect ? const Color(0xFF86EFAC) : const Color(0xFFFCA5A5),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Question {
  const _Question(this.text, this.answer);

  final String text;
  final bool answer;
}
