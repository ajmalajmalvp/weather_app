import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:weather/weather.dart';

import '../../../utils/contant.dart';

class HomeProvider extends ChangeNotifier {
  double latitude = 0;
  double longitude = 0;
  Weather? weather;
  Future<void> weatherFunction() async {
    WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
    log(weather.toString(), name: "logwe1");
    weather = await wf.currentWeatherByLocation(
      latitude,
      longitude,
    );
    log(weather.toString() + 'logwe2', name: "logwe2");
    notifyListeners();
  }

  String selectedCity = '';
  Map<String, double>? coordinates;

  Future<void> getLatLong(String cityName) async {
    // Simulating an asynchronous operation
    await Future.delayed(Duration(seconds: 1));

    // Predefined data for a few cities in India
    final predefinedData = {
      'Mumbai': {'latitude': 19.0760, 'longitude': 72.8777},
      'Delhi': {'latitude': 28.6139, 'longitude': 77.2090},
      'Bangalore': {'latitude': 12.9716, 'longitude': 77.5946},
      'Chennai': {'latitude': 13.0827, 'longitude': 80.2707},
      'Kolkata': {'latitude': 22.5726, 'longitude': 88.3639},
    };

    final data = predefinedData[cityName];
    notifyListeners();
    if (data != null) {
      coordinates = {
        'latitude': data['latitude']!,
        'longitude': data['longitude']!
      };
      latitude = coordinates!['latitude'] ?? 0;
      longitude = coordinates!['longitude'] ?? 0;
      await weatherFunction();
      notifyListeners();
    }
  }

  List cities = ['Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Kolkata'];

  void changeCity({required String value}) {
    selectedCity = value!;
    getLatLong(selectedCity);
    notifyListeners();
  }

  void valueAdd({required double latitude1, required double longitude1}) {
    latitude = latitude1;
    longitude = longitude1;
    notifyListeners();
  }
}
