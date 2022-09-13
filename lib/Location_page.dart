import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List weatherList = [];
  var icon_url;
  var Icon_url;
  int temp = 0;
  int Temp = 0;
  String cityName = "";
  String latitude = "";
  String longitude = "";
  String cityname = "";
  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print(permission);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(">>>>>>>>>>>");
    print(position);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    setState(() {});
  }

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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Location",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                image: AssetImage("images/Maps.png"),
                height: 200,
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                style: style,
                onPressed: () {
                  getLocation();
                  setState(() {});
                },
                child: const Text("Get Location"),
              ),
              const SizedBox(
                height: 30,
              ),
              latitude == ""
                  ? Container()
                  : Text(
                      "Latitude : $latitude",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
              longitude == ""
                  ? Container()
                  : Text(
                      "Longitube : $longitude",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: style,
                onPressed: () async {
                  var response = await http.get(
                    Uri.parse(
                        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=897f90491808edf00d3784208fa3cbb2&units=metric'),
                  );
                  print(">>>>>>>>>>>>>>>>>");
                  print(response.statusCode);
                  print(response.body);
                  var weatherResponse = jsonDecode(response.body);

                  print(weatherResponse['weather'][0]["description"]);
                  print(weatherResponse['main']['temp']);
                  print(weatherResponse['sys']['country']);
                  print(weatherResponse['name']);
                  cityname = weatherResponse['name'];
                  double myTemp = weatherResponse['main']['temp'];
                  Temp = myTemp.toInt();
                  Icon_url = weatherResponse["weather"][0]["icon"];
                  setState(() {});
                },
                child: const Text(
                  "Get Weather",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Icon_url == null
                  ? Container()
                  : Image.network(
                      'http://openweathermap.org/img/w/$Icon_url.png',
                    ),
              cityname == ""
                  ? Container()
                  : Text(
                      cityname,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
              const SizedBox(
                height: 30,
              ),
              Temp == 0
                  ? Container()
                  : Text(
                      Temp.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
