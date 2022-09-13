import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CiryNamePage extends StatefulWidget {
  const CiryNamePage({super.key});

  @override
  State<CiryNamePage> createState() => _CiryNamePageState();
}

class _CiryNamePageState extends State<CiryNamePage> {
  List weatherList = [];
  var icon_url;
  int temp = 0;
  String cityName = "";
  // String latitude = "";
  // String longitude = "";
  String cityname = "";
  final TextEditingController _cityController = TextEditingController();
  final ButtonStyle style =
      // ElevatedButton.styleFrom(backgroundColor: Colors.green);
      ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "CityName",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage("images/windy.jpeg"),
            radius: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                border: InputBorder.none,
                hintText: "Enter city name",
                labelText: "City",
              ),
              controller: _cityController,
            ),
          ),
          ElevatedButton(
            style: style,
            onPressed: () async {
              var response = await http.get(
                Uri.parse(
                  "https://api.openweathermap.org/data/2.5/weather?q=${_cityController.text}&appid=897f90491808edf00d3784208fa3cbb2&units=metric",
                ),
              );

              print(">>>>>>>>>>>>>>>>>");
              print(response.statusCode);
              print(response.body);
              var weatherResponse = jsonDecode(response.body);

              print(weatherResponse['weather'][0]["description"]);
              print(weatherResponse['main']['temp']);
              // print(weatherResponse['sys']['country']);
              print(weatherResponse['name']);
              cityName = weatherResponse['name'];
              double myTemp = weatherResponse['main']['temp'];
              temp = myTemp.toInt();
              icon_url = weatherResponse["weather"][0]["icon"];
              setState(() {});
            },
            child: const Text(
              "Get Weather",
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          icon_url == null
              ? Container()
              : Image.network(
                  'http://openweathermap.org/img/w/$icon_url.png',
                ),
          cityName == ""
              ? Container()
              : Text(
                  cityName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
          const SizedBox(
            height: 30,
          ),
          temp == 0
              ? Container()
              : Text(
                  temp.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }
}
