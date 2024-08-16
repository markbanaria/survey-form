# flutter_cx_nps_survey

A Flutter package for creating and managing Customer Experience (CX) and Net Promoter Score (NPS) surveys. This package allows you to easily generate customizable surveys, collect responses, and submit them to your server using HTTP or GraphQL APIs.

Try it here: https://insurance-wallet.vercel.app/

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
import 'package:flutter_cx_nps_survey/flutter_cx_nps_survey.dart'; // Import your CX package

class SurveyBlankPage extends StatefulWidget {
  @override
  _SurveyBlankPageState createState() => _SurveyBlankPageState();
}

class _SurveyBlankPageState extends State<SurveyBlankPage> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    // Define a simple NPS survey configuration with star rating input
    final SurveyConfig surveyConfig = SurveyConfig(
      title: 'Net Promoter Score Survey',
      description: 'Please rate your experience with our service.',
      questions: [
        SurveyQuestion(
          question: 'How likely are you to recommend our service to a friend or colleague?',
          inputType: InputType.starRating, // Use star rating input for NPS
          maxRating: 10, // NPS usually ranges from 0 to 10
        ),
      ],
    );

    // Define the submission configuration
    final SubmissionConfig<Map<String, dynamic>> submissionConfig = jsonSubmissionConfig(
      url: 'https://your-api-endpoint.com/api/nps/submit', // Replace with your API endpoint
      headers: {'Content-Type': 'application/json'},
      onSubmit: () {
        setState(() {
          _isSubmitting = true;
        });
      },
      onSuccess: () {
        setState(() {
          _isSubmitting = false;
        });
        // Handle success (e.g., show a confirmation message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Survey submitted successfully!')),
        );
      },
      onError: (error) {
        setState(() {
          _isSubmitting = false;
        });
        // Handle error (e.g., show an error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit survey: $error')),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Blank Survey'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    // Survey form
                    SurveyForm(
                      config: surveyConfig,
                      submissionConfig: submissionConfig,
                    ),
                    if (_isSubmitting)
                      Center(
                        child: CircularProgressIndicator(), // Spinner during submission
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
final SubmissionConfig<Map<String, dynamic>> submissionConfig = jsonSubmissionConfig(
  url: 'https://your-api-endpoint.com/api/nps/submit',
  headers: {'Content-Type': 'application/json'},
  onSubmit: () {
    // Handle pre-submission state, e.g., showing a loading indicator
  },
  onSuccess: () {
    // Handle success state, e.g., showing a success message
  },
  onError: (error) {
    // Handle error state, e.g., showing an error message
  },
);
```

### 2. **GraphQL Request**

For GraphQL submissions, configure the `SubmissionConfig` with the `graph` submission type using the `graphql_flutter` package. 

**Example:**

```dart
final SubmissionConfig<Map<String, dynamic>> submissionConfig = SubmissionConfig(
  type: SubmissionType.graph,
  url: 'https://your-graphql-endpoint.com/graphql', // Replace with your GraphQL endpoint
  headers: {'Content-Type': 'application/json'},
  bodyBuilder: (data) => {
    'query': '''
      mutation SubmitNpsSurvey(\$input: NpsSurveyInput!) {
        submitNpsSurvey(input: \$input) {
          success
          message
        }
      }
    ''',
    'variables': {
      'input': {
        'score': data['nps_question'], // Map the survey data to the GraphQL variables
        'comments': data['additional_comments'] ?? '', // Optional comments field
      }
    }
  },
  onSubmit: () {
    // Handle pre-submission state, e.g., showing a loading indicator
  },
  onSuccess: () {
    // Handle success state, e.g., showing a success message
  },
  onError: (error) {
    // Handle error state, e.g., showing an error message
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