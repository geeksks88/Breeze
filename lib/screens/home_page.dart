// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> text = [];
  String text2 = '';
  final TextEditingController _location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.network(
              'https://images.pexels.com/photos/66997/pexels-photo-66997.jpeg?auto=compress&cs=tinysrgb&w=600',
              fit: BoxFit.cover,
              width: width,
              height: height,
              opacity: AlwaysStoppedAnimation(0.55),
            ),
            //---------------------------------------------------------------------------------------------------------
            Positioned(
              top: height * 0.043,
              // bottom: width * 2.01,
              left: width * 0.1,
              right: width * 0.1,
              child: TextField(
                controller: _location,
                decoration: InputDecoration(
                  hintText: 'Enter Location',
                  contentPadding: EdgeInsets.all(10),
                  icon: Icon(Icons.search),
                ),
                onSubmitted: (value) => weatherApi(value),
              ),
            ),
            //---------------------------------------------------------------------------------------------------------
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Column(
                  children: [
                    Text(
                      text2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    if (text.isNotEmpty)
                      Text(
                        '${((text[0]['temp'] - 32) * 5 / 9).toStringAsFixed(1)}°C',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 80,
                        ),
                      ),
                    // const SizedBox(height: 5),
                    IconButton(
                      onPressed: () {
                        weatherApi(_location.text.trim());
                      },
                      icon: const Icon(Icons.refresh, size: 30),
                    ),
                  ],
                ),
              ),
            ),
            //---------------------------------------------------------------------------------------------------------
            Positioned(
              top: height * 0.38,
              left: width * 0.2,
              right: width * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        WeatherIcons.sunrise,
                        color: Colors.lightBlue.shade800.withOpacity(0.4),
                        size: width * 0.12,
                      ),
                      SizedBox(height: height * 0.015),
                      if (text.isNotEmpty)
                        Text(
                          '${(text[0]['sunrise'])}',
                          style: TextStyle(fontSize: width * 0.05),
                        ),
                    ],
                  ),
                  SizedBox(width: width * 0.058),
                  Column(
                    children: [
                      Icon(
                        WeatherIcons.sunset,
                        color: Colors.lightBlue.shade800.withOpacity(0.4),
                        size: width * 0.12,
                      ),
                      SizedBox(height: height * 0.015),
                      if (text.isNotEmpty)
                        Text(
                          '  ${(text[0]['sunset'])}',
                          style: TextStyle(fontSize: width * 0.05),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            //---------------------------------------------------------------------------------------------------------
            Positioned(
              top: height * 0.55,
              left: width * 0.06,
              child: Row(
                children: [
                  Container(
                    height: height * 0.15,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.3),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer,
                          // offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.water_drop_outlined,
                          size: width * 0.09,
                          color: Colors.blueGrey.withOpacity(0.7),
                        ),
                        SizedBox(height: height * 0.002),
                        Text(
                          'Dew',
                          style: TextStyle(
                            color: Colors.blueGrey.withOpacity(0.8),
                            fontSize: height * 0.02,
                          ),
                        ),
                        if (text.isNotEmpty)
                          Text(
                            '${(text[0]['dew']).toStringAsFixed(1)}',

                            style: TextStyle(
                              fontSize: height * 0.04,
                              color: Colors.blueGrey,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: width * 0.073),
                  Container(
                    height: height * 0.15,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer,
                          // offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          WeatherIcons.rain,
                          size: width * 0.09,
                          color: Colors.blueGrey.withOpacity(0.7),
                        ),
                        SizedBox(height: height * 0.008),
                        Text(
                          'Precip.',
                          style: TextStyle(
                            color: Colors.blueGrey.withOpacity(0.8),
                            fontSize: height * 0.02,
                          ),
                        ),
                        if (text.isNotEmpty)
                          Text(
                            '${(text[0]['precip']).toStringAsFixed(1)}%',

                            style: TextStyle(
                              fontSize: height * 0.04,
                              color: Colors.blueGrey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: height * 0.73,
              left: width * 0.06,
              child: Row(
                children: [
                  Container(
                    height: height * 0.15,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer,
                          // offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.line_weight_rounded,
                          size: width * 0.09,
                          color: Colors.blueGrey.withOpacity(0.7),
                        ),
                        SizedBox(height: height * 0.002),
                        Text(
                          'Pressure',
                          style: TextStyle(
                            color: Colors.blueGrey.withOpacity(0.8),
                            fontSize: height * 0.02,
                          ),
                        ),
                        if (text.isNotEmpty)
                          Text(
                            '${(text[0]['pressure']).toStringAsFixed(1)}',

                            style: TextStyle(
                              fontSize: height * 0.04,
                              color: Colors.blueGrey,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: width * 0.073),
                  Container(
                    height: height * 0.15,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer,
                          // offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          WeatherIcons.wind_beaufort_11,
                          size: width * 0.09,
                          color: Colors.blueGrey.withOpacity(0.7),
                        ),
                        SizedBox(height: height * 0.002),
                        Text(
                          'Wind Speed',
                          style: TextStyle(
                            color: Colors.blueGrey.withOpacity(0.8),
                            fontSize: height * 0.02,
                          ),
                        ),
                        if (text.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,

                            children: [
                              Text(
                                '${(text[0]['windspeed']).toStringAsFixed(1)}',

                                style: TextStyle(
                                  fontSize: height * 0.04,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Text(
                                ' km/h',
                                style: TextStyle(
                                  color: Colors.blueGrey.withOpacity(1),
                                  fontSize: height * 0.02,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void weatherApi(String location) async {
    final url =
        "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$location?key=XC3U3LCXKSHPLPKHMYZW6QCXK";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      final result = json['days'];
      final result2 = json['resolvedAddress'];

      setState(() {
        text = result;
        text2 = result2;
      });
    } else {
      print('Error Fetching Details');
    }
  }
}
