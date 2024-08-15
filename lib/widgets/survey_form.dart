// lib/widgets/survey_form.dart
import 'package:flutter/material.dart';
import '../models/submission_config.dart'; // Correct import for SubmissionConfig
import '../src/submission_manager.dart'; // Import the SubmissionManager
import '../src/survey_config.dart';

class SurveyForm extends StatefulWidget {
  final SurveyConfig config;
  final SubmissionManager submissionManager = SubmissionManager();
  final SubmissionConfig submissionConfig;

  SurveyForm({required this.config, required this.submissionConfig});

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.config.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.config.description,
              style: TextStyle(fontSize: 16.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.config.questions.length,
                itemBuilder: (context, index) {
                  final question = widget.config.questions[index];
                  return _buildQuestionWidget(question);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final submissionObject = widget.submissionManager.generateSubmissionObject();
                widget.submissionManager.submitSurvey(widget.submissionConfig);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(SurveyQuestion question) {
    switch (question.inputType) {
      case InputType.textField:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: question.question,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              widget.submissionManager.collectResponse(question.question, value);
            },
          ),
        );
      case InputType.starRating:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.question),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(question.maxRating ?? 5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < (widget.submissionManager.surveyResponses[question.question] ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.submissionManager.collectResponse(question.question, index + 1);
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        );
      case InputType.radioButton:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.question),
              ...question.options!.map((option) {
                return RadioListTile(
                  title: Text(option),
                  value: option,
                  groupValue: widget.submissionManager.surveyResponses[question.question],
                  onChanged: (value) {
                    setState(() {
                      widget.submissionManager.collectResponse(question.question, value);
                    });
                  },
                );
              }).toList(),
            ],
          ),
        );
      case InputType.checkbox:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.question),
              ...question.options!.map((option) {
                return CheckboxListTile(
                  title: Text(option),
                  value: (widget.submissionManager.surveyResponses[question.question] ?? []).contains(option),
                  onChanged: (isSelected) {
                    setState(() {
                      List<String> selectedOptions = widget.submissionManager.surveyResponses[question.question] ?? [];
                      if (isSelected == true) {
                        selectedOptions.add(option);
                      } else {
                        selectedOptions.remove(option);
                      }
                      widget.submissionManager.collectResponse(question.question, selectedOptions);
                    });
                  },
                );
              }).toList(),
            ],
          ),
        );
      case InputType.slider:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.question),
              Slider(
                value: (widget.submissionManager.surveyResponses[question.question] ?? question.minSliderValue)!.toDouble(),
                min: question.minSliderValue ?? 0,
                max: question.maxSliderValue ?? 100,
                onChanged: (value) {
                  setState(() {
                    widget.submissionManager.collectResponse(question.question, value);
                  });
                },
              ),
              Text('Value: ${(widget.submissionManager.surveyResponses[question.question] ?? question.minSliderValue).toStringAsFixed(1)}'),
            ],
          ),
        );
      default:
        return Container();
    }
  }
}
