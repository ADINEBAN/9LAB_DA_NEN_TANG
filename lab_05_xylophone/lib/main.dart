import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xylophone',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0FA3B1),
          brightness: Brightness.dark,
        ),
      ),
      home: const XylophonePage(),
    );
  }
}

class XylophonePage extends StatefulWidget {
  const XylophonePage({super.key});

  @override
  State<XylophonePage> createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  final List<_Note> _notes = const [
    _Note('Do', Color(0xFFFF595E)),
    _Note('Re', Color(0xFFFF924C)),
    _Note('Mi', Color(0xFFFFCA3A)),
    _Note('Fa', Color(0xFF8AC926)),
    _Note('Sol', Color(0xFF1982C4)),
    _Note('La', Color(0xFF6A4C93)),
    _Note('Si', Color(0xFFF15BB5)),
  ];

  int _activeIndex = 0;

  void _playNote(int index) {
    SystemSound.play(SystemSoundType.click);
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final active = _notes[_activeIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF090B13), Color(0xFF101A2C), Color(0xFF081018)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'COLOR KEYS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: active.color.withOpacity(0.15),
                  border: Border.all(color: active.color.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.music_note_rounded, color: active.color),
                    const SizedBox(width: 10),
                    Text(
                      'Now playing: ${active.label}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: active.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: List.generate(_notes.length, (index) {
                      final note = _notes[index];
                      final isActive = index == _activeIndex;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onTap: () => _playNote(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: note.color,
                                boxShadow: [
                                  BoxShadow(
                                    color: note.color.withOpacity(isActive ? 0.5 : 0.2),
                                    blurRadius: isActive ? 28 : 14,
                                    spreadRadius: isActive ? 1 : 0,
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 22),
                                  child: Text(
                                    note.label,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Note {
  const _Note(this.label, this.color);

  final String label;
  final Color color;
}
