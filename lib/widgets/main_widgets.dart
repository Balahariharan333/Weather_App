import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidgets extends StatelessWidget {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  MainWidgets({
    required this.location,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Color(0xfff1f1f1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${location.toString()}",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("${temp.toInt()}℃",style: TextStyle(fontWeight: FontWeight.w900,
                  fontSize: 40,
                  color: Colors.purple),),    
                ),
                Text("High of ${tempMax.toInt().toString()}℃ of ${tempMin.toInt().toString()}℃",
                style: TextStyle(color: Color(0xff9e9e9e),
                fontSize: 14,
                fontWeight: FontWeight.w600),),

              ],
            ),
          ),
          Expanded(child: Padding(padding: EdgeInsets.all(12),child: ListView(
            children: [
              WeatherTile(icon: Icons.thermostat_outlined, title: "Temperature", subtitle: "${temp.toInt().toString()}℃"),
               WeatherTile(icon: Icons.filter_drama_outlined, title: "weather", subtitle: "${weather.toString()}℃"),
                WeatherTile(icon: Icons.wb_sunny, title: "Humidity", subtitle: "${humidity.toInt().toString()}%"),
                 WeatherTile(icon: Icons.waves_outlined, title: "Wind Speed", subtitle: "${windSpeed.toInt().toString()} MPH")

            ],
          ),))
        ],
      ),
    );
  }
}
