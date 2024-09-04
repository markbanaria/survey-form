# flutter_cx_nps_survey
Purpose: this project is to demonstrate an approach to and NPS survey

A Flutter package for creating and managing Customer Experience (CX) and Net Promoter Score (NPS) surveys. This package allows you to easily generate customizable surveys, collect responses, and submit them to your server via api.

Try it here: https://insurance-wallet.vercel.app/
Download zip: 

## Objective

The `flutter_cx_nps_survey` package provides a reusable survey component for Flutter applications. It supports various input types like NPS fields, star ratings, text, that can be configured through a CMS. To use the package, simply import to your project and either show or trigger the component. 

## Installation

To install the package, add `flutter_cx_nps_survey` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_cx_nps_survey:
    path: '../path/to/package'
```

After updating your `pubspec.yaml`, run the following command to fetch the package:

```bash
flutter pub get
```

## Usage

Here’s an example of how to use the `flutter_cx_nps_survey` package in your Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_cx_nps_survey/flutter_cx_nps_survey.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page with Survey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SurveyPage(),
    );
  }
}

class SurveyPage extends StatefulWidget {
  final String questionSet = "NPS"; // Set this to the desired question set
  final String customerId = "CON345678"; // Example customer ID

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  void _showSurvey() {
    //generate the widget
    SurveyForm.showSurveyDialog(
      context: context,
      surveyQuestionSet: widget.questionSet,
      customerId: widget.customerId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          //trigger the widget
          onPressed: _showSurvey,
          child: Text('Log Out'),
        ),
      ),
    );
  }
}

```

## API

The package comes with 3 helper apis that come pre-configured:
1. Show/Hide based on customer ID
2. Geenrate question set
3. Submit 

## Key Features
- **Customizable Surveys:** Configure different types of questions, including text fields, star ratings, radio buttons, checkboxes, and sliders.
- **Abstracted Submission Logic:** pre-configured submission logic.
- **Reusable Components:** The survey components are reusable and can be easily integrated into any Flutter application.

## Future Enhancements
- **API handling:** generate API parameters based on the app/LBU 
- **CMS integration:** use a CMS to generate different question sets. then simply call them by name when you implmenet the widget