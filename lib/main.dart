import 'package:flutter/material.dart';
import 'screens/converter_screen.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

/// Main application widget that sets up the MaterialApp
class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ConverterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
