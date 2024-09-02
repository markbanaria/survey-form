import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/survey_config.dart';
import 'Rating1to10.dart';
import 'Rating1to5.dart';

class SurveyForm extends StatefulWidget {
  const SurveyForm({
    super.key,
    required this.title,
    required this.surveyQuestionSet,
  });

  final String title;
  final SurveyQuestionSet surveyQuestionSet;

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  late List<QuestionReference> _questions;
  late Map<String, Question> _questionMap;

  @override
  void initState() {
    super.initState();
    _questions = widget.surveyQuestionSet.questions;
    _questionMap = _loadQuestionMap(); // Method to map code to questions
  }

  Map<String, Question> _loadQuestionMap() {
    // Mocked data - in a real application, this would be loaded from JSON or similar
    return {
      "NET_PROMOTER_SCORE": Question(
        type: "Numerical1to10",
        code: "NET_PROMOTER_SCORE",
        label: "On a scale of 1 to 10, how likely are you to recommend our service to others?",
        component: "Icon1to10",
      ),
      "SECTION_HEADER": Question(
        type: "SectionHeader",
        code: "SECTION_HEADER",
        label: "Rate PRUServices in the following areas:",
        component: "", // No widget associated, this is just a label
      ),
      "CSAT_1": Question(
        type: "Numerical1to5",
        code: "CSAT_1",
        label: "Clear information and instructions",
        component: "StarRatingRow",
      ),
      "CSAT_2": Question(
        type: "Numerical1to5",
        code: "CSAT_2",
        label: "User-friendly navigation",
        component: "StarRatingRow",
      ),
      "CSAT_3": Question(
        type: "Numerical1to5",
        code: "CSAT_3",
        label: "Easy to complete transaction",
        component: "StarRatingRow",
      ),
      "CSAT_4": Question(
        type: "Numerical1to5",
        code: "CSAT_4",
        label: "Engaging design and visuals",
        component: "StarRatingRow",
      ),
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
              color: Colors.white, // Ensuring Material design
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.surveyQuestionSet.title,
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 40.0),
                    ..._buildSurveyQuestions(),
                    const SizedBox(height: 16.0),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red, // Background color
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                      ),
                      child: Text(
                        widget.surveyQuestionSet.submitLabel,
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
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
        return Container();
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
        return Text(
          question.label,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202020), // Text color
            ),
          ),
        );
    }
  }
}
