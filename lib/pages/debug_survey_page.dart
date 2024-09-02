import 'package:flutter/material.dart';

import '../models/survey_config.dart';
import '../models/submission_config.dart';
import '../services/submission_manager.dart';
import '../widgets/survey_form.dart';

class DebugSurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Debug Survey Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SurveyForm(
          config: surveyConfig,
          submissionConfig: submissionConfig,
        ),
      ),
    );
  }
}