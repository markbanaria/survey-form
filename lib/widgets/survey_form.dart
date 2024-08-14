// lib/widgets/survey_form.dart
import 'package:flutter/material.dart';
import 'text_field_widget.dart';
import 'star_rating_widget.dart';
import 'radio_buttons_widget.dart';
import 'checkboxes_widget.dart';
import 'slider_widget.dart';
import '../src/survey_config.dart';

class SurveyForm extends StatelessWidget {
  final SurveyConfig config;

  SurveyForm({required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(config.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              config.description,
              style: TextStyle(fontSize: 16.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: config.questions.length,
                itemBuilder: (context, index) {
                  final question = config.questions[index];
                  return _buildQuestionWidget(question);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add submission logic here
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
        return TextFieldWidget(
          question: question.question,
          controller: TextEditingController(),
        );
      case InputType.starRating:
        return StarRatingWidget(
          question: question.question,
          maxRating: question.maxRating ?? 5,
          onRatingSelected: (rating) {
            // Handle rating selected
          },
        );
      case InputType.radioButton:
        return RadioButtonsWidget(
          question: question.question,
          options: question.options ?? [],
          onSelected: (selected) {
            // Handle radio button selection
          },
        );
      case InputType.checkbox:
        return CheckboxesWidget(
          question: question.question,
          options: question.options ?? [],
          onSelectionChanged: (selected) {
            // Handle checkbox selection
          },
        );
      case InputType.slider:
        return SliderWidget(
          question: question.question,
          min: question.minSliderValue ?? 0,
          max: question.maxSliderValue ?? 100,
          onChanged: (value) {
            // Handle slider value change
          },
        );
      default:
        return Container();
    }
  }
}
