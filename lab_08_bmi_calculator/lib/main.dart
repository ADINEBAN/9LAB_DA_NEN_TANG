import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF25F5C),
          brightness: Brightness.dark,
        ),
      ),
      home: const BmiPage(),
    );
  }
}

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  String _selectedGender = 'Male';
  double _height = 170;
  int _weight = 65;
  int _age = 21;
  double? _bmi;

  void _calculate() {
    final meters = _height / 100;
    setState(() {
      _bmi = _weight / (meters * meters);
    });
  }

  String get _bmiLabel {
    final bmi = _bmi;
    if (bmi == null) {
      return 'Ready';
    }
    if (bmi < 18.5) {
      return 'Underweight';
    }
    if (bmi < 25) {
      return 'Normal';
    }
    if (bmi < 30) {
      return 'Overweight';
    }
    return 'Obese';
  }

  Color get _bmiColor {
    final bmi = _bmi;
    if (bmi == null) {
      return const Color(0xFFFFCA3A);
    }
    if (bmi < 18.5) {
      return const Color(0xFF4CC9F0);
    }
    if (bmi < 25) {
      return const Color(0xFF80ED99);
    }
    if (bmi < 30) {
      return const Color(0xFFFFCA3A);
    }
    return const Color(0xFFFF595E);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF161625), Color(0xFF291B3E), Color(0xFFE06C75)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'BMI CALCULATOR',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.6,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _SelectorCard(
                        label: 'Male',
                        icon: Icons.male_rounded,
                        selected: _selectedGender == 'Male',
                        onTap: () => setState(() => _selectedGender = 'Male'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _SelectorCard(
                        label: 'Female',
                        icon: Icons.female_rounded,
                        selected: _selectedGender == 'Female',
                        onTap: () => setState(() => _selectedGender = 'Female'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _Panel(
                  child: Column(
                    children: [
                      Text(
                        'Height',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          text: _height.round().toString(),
                          style: const TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: ' cm',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.72),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Slider(
                        min: 120,
                        max: 220,
                        value: _height,
                        onChanged: (value) => setState(() => _height = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _StepperCard(
                        title: 'Weight',
                        value: _weight.toString(),
                        onMinus: () => setState(
                          () => _weight = (_weight - 1).clamp(20, 250) as int,
                        ),
                        onPlus: () => setState(
                          () => _weight = (_weight + 1).clamp(20, 250) as int,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _StepperCard(
                        title: 'Age',
                        value: _age.toString(),
                        onMinus: () => setState(
                          () => _age = (_age - 1).clamp(10, 100) as int,
                        ),
                        onPlus: () => setState(
                          () => _age = (_age + 1).clamp(10, 100) as int,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _Panel(
                  child: Column(
                    children: [
                      Text(
                        _bmi?.toStringAsFixed(1) ?? '--',
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _bmiLabel,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _bmiColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFF25F5C),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  onPressed: _calculate,
                  child: const Text(
                    'Calculate BMI',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
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

class _SelectorCard extends StatelessWidget {
  const _SelectorCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: selected ? const Color(0x33F25F5C) : Colors.white.withOpacity(0.08),
          border: Border.all(
            color: selected ? const Color(0xFFF25F5C) : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 42, color: selected ? const Color(0xFFFFC8C7) : Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepperCard extends StatelessWidget {
  const _StepperCard({
    required this.title,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  final String title;
  final String value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.white.withOpacity(0.7))),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundIconButton(icon: Icons.remove, onTap: onMinus),
              const SizedBox(width: 12),
              _RoundIconButton(icon: Icons.add, onTap: onPlus),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
        ),
        child: Icon(icon),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.white.withOpacity(0.08),
      ),
      child: child,
    );
  }
}
