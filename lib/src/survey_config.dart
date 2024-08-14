// lib/src/survey_config.dart
enum InputType {
  textField,
  starRating,
  radioButton,
  checkbox,
  slider,
}

class SurveyQuestion {
  final String question;
  final InputType inputType;
  final List<String>? options; // Used for radio buttons or checkboxes
  final int? maxRating; // Used for star ratings
  final double? minSliderValue; // Used for sliders
  final double? maxSliderValue;

  SurveyQuestion({
    required this.question,
    required this.inputType,
    this.options,
    this.maxRating,
    this.minSliderValue,
    this.maxSliderValue,
  });
}

class SurveyConfig {
  final String title;
  final String description;
  final List<SurveyQuestion> questions;

  SurveyConfig({
    required this.title,
    required this.description,
    required this.questions,
  });
}
