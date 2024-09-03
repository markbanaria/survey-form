import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/survey_config.dart';
import 'Rating1to10.dart';
import 'Rating1to5.dart';

class SurveyForm extends StatefulWidget {
  const SurveyForm({
    super.key,
    required this.surveyQuestionSet,
    required this.customer,
  });

  final String surveyQuestionSet;
  final String customer;

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  late List<QuestionReference> _questions = [];
  late Map<String, Question> _questionMap = {};

  @override
  void initState() {
    super.initState();
    _loadSurveyData();
  }

  Future<void> _loadSurveyData() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/question_set.json");
    final jsonData = json.decode(data);

    final selectedSet = (jsonData["question_sets"] as List<dynamic>)
        .firstWhere((set) => set["name"] == widget.surveyQuestionSet, orElse: () => null);

    if (selectedSet != null) {
      setState(() {
        _questions = (selectedSet["questions"] as List<dynamic>)
            .map((q) => QuestionReference.fromJson(q))
            .toList();
        _questionMap = _mapQuestions((jsonData["questions"] as List<dynamic>)
            .map((q) => Question.fromJson(q))
            .toList());
      });
    }
  }

  Map<String, Question> _mapQuestions(List<Question> questions) {
    return {
      for (var question in questions) question.code: question,
    };
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Align(
          alignment: Alignment.topRight,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            child: Material(
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.surveyQuestionSet, // Assuming title matches set name
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 40.0),
                    Expanded(
                      child: ListView(children: _buildSurveyQuestions()),
                    ),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                        ),
                        child: Text(
                          "Submit", // Assuming submit label is constant for now
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Handle form submission here
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSurveyQuestions() {
    return _questions.map((questionRef) {
      final question = _questionMap[questionRef.code];
      if (question == null) {
        return const SizedBox.shrink();
      }

      return _buildQuestionWidget(question);
    }).toList();
  }

  Widget _buildQuestionWidget(Question question) {
    switch (question.component) {
      case "Icon1to10":
        return Icon1to10(); // Replace with your actual widget
      case "StarRatingRow":
        return StarRatingRow(text: question.label);
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            question.label,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202020), // Text color
              ),
            ),
          ),
        );
    }
  }
}
