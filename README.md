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
      url: https://github.com/markbanaria/survey-form.git
      ref: master
```

After updating your `pubspec.yaml`, run the following command to fetch the package:

```bash
flutter pub get
```

## Usage

Here’s an example of how to use the `flutter_cx_nps_survey` package in your Flutter app:

```dart
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
      onSubmit: () {
        print('Survey submission started.');
      },
      onSuccess: () {
        print('Survey submitted successfully via HTTP!');
      },
      onError: (error) {
        print('Failed to submit survey: $error');
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
```

## Input Widgets

The package provides several input widgets that can be used to create a survey form. Below is an explanation of each widget:

### 1. **TextFieldWidget**

The `TextFieldWidget` is used for open-ended questions where the respondent can type their answer. 

**Example:**

```dart
SurveyQuestion(
  question: 'Any additional comments?',
  inputType: InputType.textField,
)
```

### 2. **StarRatingWidget**

The `StarRatingWidget` allows users to rate an item on a scale, typically from 1 to 5 stars.

**Example:**

```dart
SurveyQuestion(
  question: 'Rate the quality of our products',
  inputType: InputType.starRating,
  maxRating: 5,
)
```

### 3. **RadioButtonsWidget**

The `RadioButtonsWidget` is used for single-choice questions, where the respondent can select one option from a list.

**Example:**

```dart
SurveyQuestion(
  question: 'How satisfied are you with our service?',
  inputType: InputType.radioButton,
  options: ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied', 'Very Dissatisfied'],
)
```

### 4. **CheckboxesWidget**

The `CheckboxesWidget` allows respondents to select multiple options from a list.

**Example:**

```dart
SurveyQuestion(
  question: 'What features do you use?',
  inputType: InputType.checkbox,
  options: ['Feature A', 'Feature B', 'Feature C'],
)
```

### 5. **SliderWidget**

The `SliderWidget` is used for range-based questions, where respondents can select a value within a defined range.

**Example:**

```dart
SurveyQuestion(
  question: 'How likely are you to recommend our service?',
  inputType: InputType.slider,
  minSliderValue: 0,
  maxSliderValue: 10,
)
```

## API Requests

The package supports both HTTP and GraphQL for submitting survey responses.

### 1. **HTTP Request**

To submit survey responses using an HTTP request, configure the `SubmissionConfig` with the `http` submission type. You will need to provide the API endpoint URL, headers, a body builder function, and optionally, callbacks to handle events like submission start, success, and error.

**Example:**

```dart
final submissionConfigHttp = SubmissionConfig(
  type: SubmissionType.http,
  url: 'https://yourapi.com/submit-survey',
  headers: {'Content-Type': 'application/json'},
  bodyBuilder: (data) {
    return data; // Directly use the survey data as the body
  },
  onSubmit: () {
    print('Survey submission started.');
  },
  onSuccess: () {
    print('Survey submitted successfully via HTTP!');
  },
  onError: (error) {
    print('Failed to submit survey: $error');
  },
);
```

### 2. **GraphQL Request**

For GraphQL submissions, configure the `SubmissionConfig` with the `graph` submission type using the `graphql_flutter` package. 

**Example:**

```dart
final submissionConfigGraph = SubmissionConfig(
  type: SubmissionType.graph,
  url: 'https://yourapi.com/graphql',
  headers: {'Content-Type': 'application/json'},
  bodyBuilder: (data) {
    return {
      'query': '''
        mutation SubmitSurvey(\$input: SurveyInput!) {
          submitSurvey(input: \$input) {
            success
            message
          }
        }
      ''',
      'variables': {
        'input': data, // Pass the survey data as GraphQL variables
      },
    };
  },
  onSubmit: () {
    print('Survey submission started.');
  },
  onSuccess: () {
    print('Survey submitted successfully via GraphQL!');
  },
  onError: (error) {
    print('Failed to submit survey: $error');
  },
);
```

## Key Features
- **Customizable Surveys:** Configure different types of questions, including text fields, star ratings, radio buttons, checkboxes, and sliders.
- **Abstracted Submission Logic:** Easily configure the submission logic to use either HTTP or GraphQL APIs.
- **Reusable Components:** The survey components are reusable and can be easily integrated into any Flutter application.

## Future Enhancements
- **Customer Eligibility Handling:** Integration with a CRM or another API to determine if a survey should be shown to a specific customer.
- **Additional Input Types:** Support for more input types, such as date pickers or custom widgets.