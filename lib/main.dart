// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'widgets/main_widgets.dart';

void main() {
  runApp(MyApp());
}

Future<WeatherInfo> fetchWeather() async {
  final lat = 11.0735;
  final lon = 77.3459;
  final apikey = "f237a54bcd6a18747e238ae9c2fddd90";
  final requestUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apikey}&units=metric";

  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading request");
  }
}

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo({
    required this.location,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      weather: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MainAppState();
}

class _MainAppState extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;
  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tn Weather App",
      home: Scaffold(
        body: FutureBuilder<WeatherInfo>(
          future: futureWeather,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return MainWidgets(
                location: snapShot.data?.location,
                temp: snapShot.data?.temp,
                tempMin: snapShot.data?.tempMin,
                tempMax: snapShot.data?.tempMax,
                weather: snapShot.data?.weather,
                humidity: snapShot.data?.humidity,
                windSpeed: snapShot.data?.windSpeed,
              );
            }  else if (snapShot.hasError) {
                return Center(child: Text("Error: ${snapShot.error}"));
               }

            return Container();
          },
        ),
      ),
    );
  }
}
