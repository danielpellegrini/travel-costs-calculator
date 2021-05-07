import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculate Travel Costs',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: CostsCalcScreen(), // <- costruttore del widget
    );
  }
}

class CostsCalcScreen extends StatefulWidget {
  @override
  _CostsCalcScreenState createState() => _CostsCalcScreenState();
  // l'underscore prima del nome della classe indica che la classe non sarà accessibile fuori dal file main.dart
}

class _CostsCalcScreenState extends State<CostsCalcScreen> {
  String routeType;
  String message = '';
  final TextEditingController kilometersController = TextEditingController();

  final List<String> routeTypes = ['City', 'Suburban', 'Mixed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Calculate travel cost',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: kilometersController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[800],
              ),
              decoration: InputDecoration(
                  hintText: 'How many kilometers?',
                  hintStyle: TextStyle(
                    fontSize: 18,
                  )),
            ),
            Spacer(),
            DropdownButton<String>(
              value: routeType,
              items: routeTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[800],
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  routeType = newValue;
                });
              },
            ),
            Spacer(
              flex: 2,
            ),
            RaisedButton(
              onPressed: () {
                costCalculator();
              },
              child: Text(
                'Calculate cost',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              color: Colors.orange,
            ),
            Spacer(
              flex: 4,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void costCalculator() {
    double fuelLiterCost = 1.4;
    double kilometersNumber = double.tryParse(kilometersController.text);
    double kmRouteType;
    double cost;

    if (routeType == routeTypes[0]) {
      kmRouteType = 14;
    } else if (routeType == routeTypes[1]) {
      kmRouteType = 18;
    } else {
      kmRouteType = 16;
    }
    cost = kilometersNumber * fuelLiterCost / kmRouteType;
    setState(() {
      message =
          'The expected cost for your travel is: ' + cost.toString() + ' €';
    });
  }
}
