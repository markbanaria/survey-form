import 'package:flutter/material.dart';
import 'package:flutter_cx_nps_survey/flutter_cx_nps_survey.dart'; // Importing the survey package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page with Survey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SurveyPage(),
    );
  }
}

class SurveyPage extends StatefulWidget {
  final String questionSet = "NPS"; // Set this to the desired question set
  final String customerId = "CON345678";

  const SurveyPage({super.key}); // Example customer ID

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  void _showSurvey() {
    // Use the method from the survey package to show the survey dialog
    SurveyBusinessWidget.showSurveyDialog(
      context: context,
      surveyQuestionSet: widget.questionSet,
      customerId: widget.customerId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showSurvey,
          child: const Text('logout'),
        ),
      ),
    );
  }
}
