import 'package:flutter/material.dart';

void main() {
  runApp(const DestiniApp());
}

class DestiniApp extends StatelessWidget {
  const DestiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Destini',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C3AED),
          brightness: Brightness.dark,
        ),
      ),
      home: const DestiniPage(),
    );
  }
}

class DestiniPage extends StatefulWidget {
  const DestiniPage({super.key});

  @override
  State<DestiniPage> createState() => _DestiniPageState();
}

class _DestiniPageState extends State<DestiniPage> {
  final Map<String, _StoryNode> _story = {
    'start': const _StoryNode(
      text:
          'Your car breaks down on a lonely mountain road. A truck stops beside you and the driver asks where you are heading.',
      choices: [
        _StoryChoice('Hop in and ask for a ride.', 'ride'),
        _StoryChoice('Politely decline and wait.', 'wait'),
      ],
    ),
    'ride': const _StoryNode(
      text:
          'Inside the truck you notice a sealed box labeled "Do not open." The driver smiles and asks if you like surprises.',
      choices: [
        _StoryChoice('Ask about the box.', 'box'),
        _StoryChoice('Change the subject.', 'music'),
      ],
    ),
    'wait': const _StoryNode(
      text:
          'You stay behind. The storm grows stronger, but a ranger jeep appears from the fog with a flashing light.',
      choices: [
        _StoryChoice('Signal the ranger jeep.', 'ranger'),
        _StoryChoice('Run back to your car.', 'car'),
      ],
    ),
    'box': const _StoryNode(
      text:
          'The driver laughs and reveals camping supplies. You spend the night by a fire and wake up with a new friend.',
      choices: [],
    ),
    'music': const _StoryNode(
      text:
          'The radio plays your favorite song. Minutes later the driver safely drops you at a hidden mountain cafe.',
      choices: [],
    ),
    'ranger': const _StoryNode(
      text:
          'The ranger helps you tow the car and shares a shortcut to town. You arrive just in time for sunrise.',
      choices: [],
    ),
    'car': const _StoryNode(
      text:
          'You lock yourself in the car, but the battery dies. Eventually you call for help and learn patience the hard way.',
      choices: [],
    ),
  };

  String _currentNodeId = 'start';

  void _selectChoice(String nextId) {
    setState(() {
      _currentNodeId = nextId;
    });
  }

  void _restart() {
    setState(() {
      _currentNodeId = 'start';
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = _story[_currentNodeId]!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1021), Color(0xFF321B5B), Color(0xFF8B5CF6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'DESTINI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(0.2),
                      border: Border.all(color: Colors.white.withOpacity(0.12)),
                    ),
                    child: Center(
                      child: Text(
                        node.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          height: 1.55,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (node.choices.isNotEmpty)
                  ...node.choices.map(
                    (choice) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF4C1D95),
                          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        ),
                        onPressed: () => _selectChoice(choice.nextId),
                        child: Text(
                          choice.label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (node.choices.isEmpty)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFF59E0B),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    onPressed: _restart,
                    icon: const Icon(Icons.replay_rounded),
                    label: const Text(
                      'Restart Story',
                      style: TextStyle(fontWeight: FontWeight.w800),
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

class _StoryNode {
  const _StoryNode({
    required this.text,
    required this.choices,
  });

  final String text;
  final List<_StoryChoice> choices;
}

class _StoryChoice {
  const _StoryChoice(this.label, this.nextId);

  final String label;
  final String nextId;
}
