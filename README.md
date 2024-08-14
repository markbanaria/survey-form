Certainly! Here is the complete README.md file with the usage section clearly included and formatted properly for easy copy-pasting:

markdown
Copy code
# flutter_cx_nps_survey

A Flutter package for creating and managing Customer Experience (CX) and Net Promoter Score (NPS) surveys. This package allows you to easily generate customizable surveys, collect responses, and submit them to your server using HTTP or GraphQL APIs.

## Objective

The `flutter_cx_nps_survey` package provides a reusable survey component for Flutter applications. It supports various input types like text fields, star ratings, radio buttons, checkboxes, and sliders. The package also includes an abstracted submission logic, allowing you to configure API endpoints and submission methods with minimal setup.

## Installation

To install the package, add `flutter_cx_nps_survey` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_cx_nps_survey:
    git:
      url: git@github.com:your-username/flutter_cx_nps_survey.git
      ref: main
Replace your-username with your GitHub username.

After updating your pubspec.yaml, run the following command to fetch the package:

bash
Copy code
flutter pub get
Usage
Here’s an example of how to use the flutter_cx_nps_survey package in your Flutter app:

dart
Copy code
import 'package:flutter/material.dart';
import 'package:flutter_cx_nps_survey/flutter_cx_nps_survey.dart'; // Import the package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CX & NPS Survey Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SurveyDemoPage(),
    );
  }
}

class SurveyDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the survey configuration
    final surveyConfig = SurveyConfig(
      title: 'Customer Satisfaction Survey',
      description: 'Please answer the following questions to help us improve our service:',
      questions: [
        SurveyQuestion(
          question: 'How satisfied are you with our service?',
          inputType: InputType.radioButton,
          options: ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied', 'Very Dissatisfied'],
        ),
        SurveyQuestion(
          question: 'Rate the quality of our products',
          inputType: InputType.starRating,
          maxRating: 5,
        ),
        SurveyQuestion(
          question: 'Any additional comments?',
          inputType: InputType.textField,
        ),
      ],
    );

    // Configure the submission for HTTP
    final submissionConfigHttp = SubmissionConfig(
      type: SubmissionType.http,
      url: 'https://yourapi.com/submit-survey',
      headers: {'Content-Type': 'application/json'},
      bodyBuilder: (data) {
        return data; // Directly use the survey data as the body
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Demo'),
      ),
      body: SurveyForm(
        config: surveyConfig,
        submissionConfig: submissionConfigHttp, // Or use your GraphQL config
      ),
    );
  }
}
Key Features
Customizable Surveys: Configure different types of questions, including text fields, star ratings, radio buttons, checkboxes, and sliders.
Abstracted Submission Logic: Easily configure the submission logic to use either HTTP or GraphQL APIs.
Reusable Components: The survey components are reusable and can be easily integrated into any Flutter application.
Future Enhancements
Customer Eligibility Handling: Integration with a CRM or another API to determine if a survey should be shown to a specific customer.
Additional Input Types: Support for more input types, such as date pickers or custom widgets.
License
This package is licensed under the MIT License. See the LICENSE file for more details.

Contributions
Contributions are welcome! If you find a bug or have a feature request, please open an issue or submit a pull request.

markdown
Copy code

### Explanation:

- **Objective**: Describes the purpose of the package.
- **Installation**: Step-by-step guide to installing the package.
- **Usage**: Code snippet demonstrating how to use the package in a Flutter app.
- **Key Features**: Highlights the main features of the package.
- **Future Enhancements**: Mentions potential future improvements.
- **License**: Licensing information.
- **Contributions**: Invites contributions from others.

You can directly copy and paste this markdown into your `README.md` file.