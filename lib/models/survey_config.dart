import 'dart:convert';

class SurveyQuestionSet {
  final String title;
  final List<QuestionReference> questions;
  final String submitLabel;

  SurveyQuestionSet({required this.title, required this.questions, required this.submitLabel});

  factory SurveyQuestionSet.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List;
    List<QuestionReference> questionsList = list.map((i) => QuestionReference.fromJson(i)).toList();

    return SurveyQuestionSet(
      title: json['title'],
      questions: questionsList,
      submitLabel: json['submit_button']['label'],
    );
  }
}

class QuestionReference {
  final int order;
  final String code;

  QuestionReference({required this.order, required this.code});

  factory QuestionReference.fromJson(Map<String, dynamic> json) {
    return QuestionReference(
      order: json['order'],
      code: json['code'],
    );
  }
}

class Question {
  final String type;
  final String code;
  final String label;
  final String component;

  Question({required this.type, required this.code, required this.label, required this.component});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      code: json['code'],
      label: json['label'],
      component: json['component'],
    );
  }
}
