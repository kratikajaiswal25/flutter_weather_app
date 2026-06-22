import 'package:flutter/material.dart';
import 'package:flutter_application/models/weather_model.dart';
import 'package:flutter_application/services/weather_services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_animation/weather_animation.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  String formatTime(int? timestamp) {
    if (timestamp == null) {
      return 'N/A';
    }
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
         margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(113,255,255,255),
  ),
  child:Column(mainAxisAlignment: MainAxisAlignment.start, 
  children: [
    Lottie.asset(
      weather.description.contains('rain') ? 'assets/rain.jfif' :
      weather.description.contains('clear') ? 'assets/sunny.jfif' :
      'assets/cloud.jfif',
      width: 150,
      height: 150,
    ),
    Text(
      weather.cityName,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
    SizedBox(height:10,),
    Text('${weather.temperature.toStringAsFixed(1)}°C',
    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),),
    SizedBox(height:10,),
    Text(weather.description,style: Theme.of(context).textTheme.titleMedium,),
    SizedBox(height:20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Humidity: ${weather.humidity}%',
       style: Theme.of(context).textTheme.bodyMedium,),
       
        Text('Wind: ${weather.windSpeed} m/s',
       style: Theme.of(context).textTheme.bodyMedium,)
       
  ],),
  
  
   SizedBox(height:20,),
   Column(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.wb_sunny_outlined,color: Colors.orange,),
        Text('Sunrise',
       style: Theme.of(context).textTheme.bodyMedium,),
       
        Text(formatTime(weather.sunrise),
       style: Theme.of(context).textTheme.bodyMedium,)
       
  ],),
   SizedBox(height:20,),
   Column(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.nights_stay_outlined,color: Colors.purple,),
        Text('Sunset',
       style: Theme.of(context).textTheme.bodyMedium,),
       
        Text(formatTime(weather.sunset),
       style: Theme.of(context).textTheme.bodyMedium,)
       
  ],),
  ],),
        ),
      ],
    );
  }
}