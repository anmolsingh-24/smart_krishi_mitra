// lib/weather_page.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _wf = WeatherFactory(
    "93fda7ded566c13a2750974586fcccb2",
  ); // replace with your key
  Weather? _currentWeather;
  List<Weather>? _forecast;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() => _loading = true);
    try {
      Position pos = await _determinePosition();
      Weather current = await _wf.currentWeatherByLocation(
        pos.latitude,
        pos.longitude,
      );
      List<Weather> forecast = await _wf.fiveDayForecastByLocation(
        pos.latitude,
        pos.longitude,
      );
      setState(() {
        _currentWeather = current;
        _forecast = forecast;
        _loading = false;
      });
    } catch (e) {
      debugPrint("Weather fetch error: $e");
      setState(() => _loading = false);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF228B22),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF228B22)),
            )
          : _currentWeather == null
          ? const Center(child: Text("Failed to load weather"))
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // City name
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _currentWeather!.areaName ?? "Your City",
                      style: TextStyle(
                        color: isDarkMode
                            ? const Color.fromARGB(255, 7, 47, 1)
                            : const Color.fromARGB(255, 7, 47, 1),
                        fontSize: size.height * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Large weather icon + temp row
                  _buildIconAndTempRow(size, isDarkMode),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    _currentWeather!.weatherDescription ?? "",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                      fontSize: size.height * 0.023,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Min/Max
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Min: ${_currentWeather!.tempMin?.celsius?.toStringAsFixed(1)}°C",
                        style: TextStyle(color: Colors.blue[700], fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Max: ${_currentWeather!.tempMax?.celsius?.toStringAsFixed(1)}°C",
                        style: TextStyle(color: Colors.red[700], fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Forecast card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDarkMode ? Colors.white10 : Colors.green[50],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "5-Day Forecast",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        if (_forecast != null)
                          Column(
                            children: _forecast!.take(5).map((w) {
                              return ListTile(
                                leading: FaIcon(
                                  _mapWeatherIcon(w.weatherMain),
                                  color: Colors.green[700],
                                ),
                                title: Text(
                                  "${_weekdayString(w.date?.weekday)} - ${w.weatherDescription ?? ""}",
                                ),
                                trailing: Text(
                                  "${w.temperature?.celsius?.toStringAsFixed(1)}°C",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  /// Builds the large icon on the left and big temp text on the right.
  Widget _buildIconAndTempRow(Size size, bool isDarkMode) {
    final main = _currentWeather!.weatherMain?.toLowerCase() ?? "";
    final iconCode =
        _currentWeather!.weatherIcon ?? ""; // OWM icon code like '01d' or '10n'
    final isDay = iconCode.endsWith('d');

    final iconData = _mapWeatherIcon(main);

    final bgColor = _chooseIconBackgroundColor(main, isDay);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon circle
          Container(
            width: size.width * 0.28,
            height: size.width * 0.28,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: FaIcon(
                iconData,
                size: size.width * 0.12,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 18),

          // temperature text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_currentWeather!.temperature?.celsius?.toStringAsFixed(1)}°C",
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: size.height * 0.11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Feels like ${_currentWeather!.temperature?.celsius?.toStringAsFixed(1)}°C",
                style: TextStyle(
                  color: isDarkMode ? Colors.white60 : Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Map simple weather main strings to FontAwesome icons
  IconData _mapWeatherIcon(String? main) {
    final key = (main ?? "").toLowerCase();
    if (key.contains("clear")) return FontAwesomeIcons.solidSun;
    if (key.contains("cloud")) return FontAwesomeIcons.cloud;
    if (key.contains("rain") || key.contains("drizzle"))
      return FontAwesomeIcons.cloudRain;
    if (key.contains("thunder") || key.contains("storm"))
      return FontAwesomeIcons.bolt;
    if (key.contains("snow")) return FontAwesomeIcons.snowflake;
    if (key.contains("mist") || key.contains("fog") || key.contains("haze"))
      return FontAwesomeIcons.smog;
    // fallback
    return FontAwesomeIcons.cloudSun;
  }

  // Choose circle background color based on condition + day/night
  Color _chooseIconBackgroundColor(String main, bool isDay) {
    final m = (main ?? "").toLowerCase();
    if (m.contains("clear"))
      return isDay ? Colors.orangeAccent.shade400 : Colors.indigo.shade700;
    if (m.contains("cloud")) return Colors.blueGrey.shade600;
    if (m.contains("rain") || m.contains("drizzle"))
      return Colors.blue.shade700;
    if (m.contains("thunder") || m.contains("storm"))
      return Colors.deepPurple.shade700;
    if (m.contains("snow")) return Colors.lightBlue.shade200;
    if (m.contains("mist") || m.contains("fog") || m.contains("haze"))
      return Colors.grey.shade600;
    return Colors.green.shade600;
  }

  String _weekdayString(int? weekday) {
    if (weekday == null) return "";
    const names = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    // Weather.date.weekday is 1..7 where 1 = Monday
    if (weekday >= 1 && weekday <= 7) return names[weekday - 1];
    return "";
  }
}
