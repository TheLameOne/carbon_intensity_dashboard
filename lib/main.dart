import 'package:carbon_intensity_dashboard/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carbon Intensity Dashboard',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
