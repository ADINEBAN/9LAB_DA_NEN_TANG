import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC5412A),
          brightness: Brightness.dark,
        ),
      ),
      home: const DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  final Random _random = Random();
  int _leftDice = 2;
  int _rightDice = 5;

  void _rollDice() {
    setState(() {
      _leftDice = _random.nextInt(6) + 1;
      _rightDice = _random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF170E15), Color(0xFF6B1F1D), Color(0xFFCF5531)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 18),
                const Text(
                  'ROLL THE NIGHT',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the button to shake two custom dice.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.76),
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    DiceFace(value: _leftDice),
                    DiceFace(value: _rightDice),
                  ],
                ),
                const SizedBox(height: 26),
                Text(
                  'Total: ${_leftDice + _rightDice}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: _rollDice,
                  icon: const Icon(Icons.casino_rounded),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                    child: Text(
                      'Roll Dice',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiceFace extends StatelessWidget {
  const DiceFace({super.key, required this.value});

  final int value;

  List<Alignment> _pipLayout(int number) {
    switch (number) {
      case 1:
        return const [Alignment.center];
      case 2:
        return const [Alignment.topLeft, Alignment.bottomRight];
      case 3:
        return const [Alignment.topLeft, Alignment.center, Alignment.bottomRight];
      case 4:
        return const [
          Alignment.topLeft,
          Alignment.topRight,
          Alignment.bottomLeft,
          Alignment.bottomRight,
        ];
      case 5:
        return const [
          Alignment.topLeft,
          Alignment.topRight,
          Alignment.center,
          Alignment.bottomLeft,
          Alignment.bottomRight,
        ];
      default:
        return const [
          Alignment.topLeft,
          Alignment.topRight,
          Alignment.centerLeft,
          Alignment.centerRight,
          Alignment.bottomLeft,
          Alignment.bottomRight,
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final pips = _pipLayout(value);
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: pips
            .map(
              (alignment) => Align(
                alignment: alignment,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFFAC2A1D),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
