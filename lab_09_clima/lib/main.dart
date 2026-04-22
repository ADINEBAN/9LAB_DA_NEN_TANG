import 'package:flutter/material.dart';

void main() {
  runApp(const ClimaApp());
}

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF38BDF8),
          brightness: Brightness.dark,
        ),
      ),
      home: const ClimaPage(),
    );
  }
}

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  final TextEditingController _controller = TextEditingController();

  final Map<String, WeatherData> _mockWeather = const {
    'da nang': WeatherData(
      city: 'Da Nang',
      temperature: 29,
      condition: 'Sunny',
      icon: Icons.wb_sunny_rounded,
      detail: 'Warm sea breeze and bright afternoon light.',
    ),
    'ha noi': WeatherData(
      city: 'Ha Noi',
      temperature: 24,
      condition: 'Cloudy',
      icon: Icons.cloud_rounded,
      detail: 'A calm skyline with layered gray clouds.',
    ),
    'ho chi minh': WeatherData(
      city: 'Ho Chi Minh City',
      temperature: 31,
      condition: 'Thunderstorm',
      icon: Icons.thunderstorm_rounded,
      detail: 'High humidity with evening showers.',
    ),
    'hue': WeatherData(
      city: 'Hue',
      temperature: 26,
      condition: 'Rain',
      icon: Icons.umbrella_rounded,
      detail: 'Soft rain moving across the river.',
    ),
    'nha trang': WeatherData(
      city: 'Nha Trang',
      temperature: 28,
      condition: 'Windy',
      icon: Icons.air_rounded,
      detail: 'Coastal wind and clear blue water.',
    ),
  };

  WeatherData _currentWeather = const WeatherData(
    city: 'Da Nang',
    temperature: 29,
    condition: 'Sunny',
    icon: Icons.wb_sunny_rounded,
    detail: 'Warm sea breeze and bright afternoon light.',
  );
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadWeather({String? city, bool useCurrentLocation = false}) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    await Future<void>.delayed(const Duration(milliseconds: 700));

    final query = useCurrentLocation ? 'da nang' : city?.trim().toLowerCase();
    final result = query == null || query.isEmpty ? null : _mockWeather[query];

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      if (result == null) {
        _error = 'City not found in demo dataset.';
      } else {
        _currentWeather = result;
      }
    });
  }

  List<Color> _backgroundFor(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return const [Color(0xFF1D3557), Color(0xFF457B9D), Color(0xFFFFB703)];
      case 'cloudy':
        return const [Color(0xFF1F2937), Color(0xFF4B5563), Color(0xFF9CA3AF)];
      case 'rain':
        return const [Color(0xFF0F172A), Color(0xFF1D4ED8), Color(0xFF38BDF8)];
      case 'thunderstorm':
        return const [Color(0xFF111827), Color(0xFF312E81), Color(0xFF8B5CF6)];
      default:
        return const [Color(0xFF0F172A), Color(0xFF0369A1), Color(0xFF22D3EE)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _backgroundFor(_currentWeather.condition);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search city',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: _isLoading
                          ? null
                          : () => _loadWeather(city: _controller.text),
                      child: const Icon(Icons.search_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _isLoading ? null : () => _loadWeather(useCurrentLocation: true),
                      icon: const Icon(Icons.my_location_rounded),
                      label: const Text('Use current location'),
                    ),
                    ..._mockWeather.values.map(
                      (weather) => ActionChip(
                        label: Text(weather.city),
                        onPressed: _isLoading ? null : () => _loadWeather(city: weather.city),
                      ),
                    ),
                  ],
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: const TextStyle(
                      color: Color(0xFFFECACA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const Spacer(),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentWeather.city,
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${_currentWeather.temperature}°',
                            style: const TextStyle(
                              fontSize: 92,
                              fontWeight: FontWeight.w900,
                              height: 0.95,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Icon(_currentWeather.icon, size: 52, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _currentWeather.condition,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white.withOpacity(0.92),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.black.withOpacity(0.18),
                        ),
                        child: Text(
                          _currentWeather.detail,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherData {
  const WeatherData({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.detail,
  });

  final String city;
  final int temperature;
  final String condition;
  final IconData icon;
  final String detail;
}
