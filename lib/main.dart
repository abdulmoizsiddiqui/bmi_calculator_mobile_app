import 'package:flutter/material.dart';
import 'dart:math'; // Import the math library for the pow function

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Welcome to the BMI Calculator 2025'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final weightController = TextEditingController();
  final feetController = TextEditingController();
  final inchesController = TextEditingController();

  Color bgColor = Colors.indigo.shade100; // Default background color
  String result = '';
  double bmi = 0;

  void calculateBMI() {
    setState(() {
      if (weightController.text.isEmpty ||
          feetController.text.isEmpty ||
          inchesController.text.isEmpty) {
        result = 'Please enter all values.';
        bgColor = Colors.indigo.shade100; // set default color
        return;
      }

      final weight = double.parse(weightController.text);
      final feet = int.parse(feetController.text);
      final inches = int.parse(inchesController.text);

      final heightInInches = (feet * 12) + inches;
      final heightInMeters =
          heightInInches * 0.0254; // Corrected height conversion
      if (heightInMeters == 0) {
        result = "Height must be greater than 0";
        bgColor = Colors.indigo.shade100; // set default color
        return;
      }

      bmi = weight / (heightInMeters * heightInMeters);

      if (bmi < 18.5) {
        result = 'You are underweight. BMI: ${bmi.toStringAsFixed(2)}';
        bgColor = Colors.red.shade200;
      } else if (bmi >= 25) {
        result = 'You are overweight. BMI: ${bmi.toStringAsFixed(2)}';
        bgColor = Colors.orange;
      } else {
        result = 'Your BMI is healthy. BMI: ${bmi.toStringAsFixed(2)}';
        bgColor = Colors.green.shade200;
      }
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    feetController.dispose();
    inchesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Your BMI'),
      ),
      body: Container(
        color: bgColor, // Use the bgColor variable here
        child: Center(
          child: SingleChildScrollView(
            // Added SingleChildScrollView
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'BMI',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      label: Text('Enter your weight in KGs'),
                      prefixIcon: Icon(Icons.line_weight),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: feetController,
                    decoration: const InputDecoration(
                      label: Text('Enter your height in feet'),
                      prefixIcon: Icon(Icons.height),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: inchesController,
                    decoration: const InputDecoration(
                      label: Text('Enter your height in inches'),
                      prefixIcon: Icon(Icons.height_outlined),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: calculateBMI,
                    child: const Text('Calculate'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
