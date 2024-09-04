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

We can enhance the sdk to load new api parameters based on a set of rules (eg. for each lbu)

## Key Features
- **Customizable Surveys:** Configure different types of questions, including text fields, star ratings, radio buttons, checkboxes, and sliders.
- **Abstracted Submission Logic:** pre-configured submission logic.
- **Reusable Components:** The survey components are reusable and can be easily integrated into any Flutter application.

## Future Enhancements
- **API handling:** generate API parameters based on the app/LBU 
- **CMS integration:** use a CMS to generate different question sets. then simply call them by name when you implmenet the widget

## To Demo in PServices

1. Update `/lib/helpers/api_config.dart` with api url
2. (2.1) SDK Method 1: Copy whole project package to front end folder, update pacs app pubspect to load this package
in pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_cx_nps_survey:
      path: "path to package location"
```
2. (2.2) 2 SDK Method 2: Copy contents of lib folder into widgets
widgets/survey/[foldercontents]
3. (3.1)Import to homepage
if method 1: `import 'package:flutter_cx_nps_survey/flutter_cx_nps_survey.dart';`
if method 2: `import '../widgets/flutter_cx_nps_survey.dart` 
3. (3.2) Implement in home page.
```dart
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
```
In this case, bind _showSurvey to any action on the page like logout. For more complex implementation we can pass the `SurveyBusinessWidget` back to the logged-out page as they navigate out.
3. (3.3) Run the test app. Navigate to `/apps/test_app` then `$ flutter run -d chrome`
4. Present `/lib/services/questions_service.dart` as questions configuration service that will connect to strapi
5. Run demo (logout then survey shown) (logout then survey hidden)
6. Higlight that all UI components will then be calibrated to any existing components
7. Higlight that feature flagging can be used in future to show/hide
