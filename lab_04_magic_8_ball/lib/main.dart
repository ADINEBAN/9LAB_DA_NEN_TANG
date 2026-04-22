import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MagicBallApp());
}

class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic 8 Ball',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MagicBallPage(),
    );
  }
}

class MagicBallPage extends StatefulWidget {
  const MagicBallPage({super.key});

  @override
  State<MagicBallPage> createState() => _MagicBallPageState();
}

class _MagicBallPageState extends State<MagicBallPage> {
  final Random _random = Random();
  final List<_Prediction> _predictions = const [
    _Prediction('Absolutely.', Color(0xFF66FFCF)),
    _Prediction('Try again later.', Color(0xFFFFD166)),
    _Prediction('The signs say no.', Color(0xFFFF7B72)),
    _Prediction('Go for it.', Color(0xFF8FD3FF)),
    _Prediction('Trust your instincts.', Color(0xFFB392F0)),
    _Prediction('A surprise is coming.', Color(0xFFFF9E6D)),
  ];

  late _Prediction _currentPrediction = _predictions.first;

  void _askTheBall() {
    setState(() {
      _currentPrediction = _predictions[_random.nextInt(_predictions.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF2F336B), Color(0xFF110D1F), Color(0xFF040308)],
            radius: 1.1,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                top: 80,
                left: 40,
                child: Icon(Icons.auto_awesome, color: Colors.white24, size: 38),
              ),
              const Positioned(
                top: 160,
                right: 48,
                child: Icon(Icons.star, color: Colors.white24, size: 24),
              ),
              const Positioned(
                bottom: 140,
                left: 64,
                child: Icon(Icons.star_purple500_outlined, color: Colors.white24, size: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      'MAGIC 8 BALL',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Ask a question, then tap the sphere for an answer.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.72),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(180),
                      onTap: _askTheBall,
                      child: Container(
                        width: 310,
                        height: 310,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF09111F), Color(0xFF0D2145)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(color: Colors.white.withOpacity(0.12)),
                          boxShadow: [
                            BoxShadow(
                              color: _currentPrediction.color.withOpacity(0.25),
                              blurRadius: 40,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 320),
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(
                              color: _currentPrediction.color.withOpacity(0.18),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _currentPrediction.color.withOpacity(0.66),
                              ),
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 260),
                                child: Padding(
                                  key: ValueKey(_currentPrediction.text),
                                  padding: const EdgeInsets.all(18),
                                  child: Text(
                                    _currentPrediction.text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _currentPrediction.color,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: _askTheBall,
                      icon: const Icon(Icons.touch_app_rounded),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                        child: Text('Ask Again'),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Prediction {
  const _Prediction(this.text, this.color);

  final String text;
  final Color color;
}
