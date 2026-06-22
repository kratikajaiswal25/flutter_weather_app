import 'package:flutter/material.dart';
import 'package:flutter_application/models/weather_model.dart';
import 'package:flutter_application/services/weather_services.dart';
import 'package:flutter_application/widgets/weather_card.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();

  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  Weather? _weather;
  void _getWeather() async {
    setState(() {
      isLoading = true;
    });
    try{
      final weather = await _weatherServices.getWeather(_controller.text);
      setState(() {
        _weather = weather;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data')),
      );
    }} 
  @override
  Widget build(BuildContext context) {
    TextEditingController controller;
    return Scaffold(
     body:Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: _weather!=null && _weather!.description.toLowerCase().contains('rain')?
            LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey,
                  Colors.blueGrey,
                ],
              )
            :_weather!=null && _weather!.description.toLowerCase().contains('clear')?
             const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.orangeAccent,
                  Colors.blueAccent,
                ],
              )
        :const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.lightBlueAccent,
          ],
        ),

      ),
      child:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
        child:Column(
        children: [
        const SizedBox(height: 25,),
        const Text ('Weather App',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          color: Colors.white,
          ),
        ),
        const SizedBox(height: 25,),
        TextField(
          controller:_controller,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter your city name',
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: const Color.fromARGB(110,255, 225, 225),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: _getWeather,
          child: Text('Get Weather', style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(200, 125, 155, 170),
            foregroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
        ),),
        if(isLoading)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(color: Colors.white,),
          ),
          if(_weather != null)
            WeatherCard(weather: _weather!),
          
        ],
        
      ),
    ),
    ),),);
    }
    }
