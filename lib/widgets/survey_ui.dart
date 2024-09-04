import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input_nps.dart';
import 'input_star.dart';
import 'input_text.dart';
import '../models/survey_config.dart';

class SurveyUI extends StatelessWidget {
  final bool isLoading;
  final String title;
  final List<QuestionReference> questions;
  final Map<String, Question> questionMap;
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final Function(String, dynamic) onAnswerUpdate;

  const SurveyUI({
    super.key,
    required this.isLoading,
    required this.title,
    required this.questions,
    required this.questionMap,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onAnswerUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show spinner while loading
          : Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 32),
                  Expanded(child: ListView(children: _buildSurveyQuestions())),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: isSubmitting
                        ? const CircularProgressIndicator() // Show spinner while submitting
                        : TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 24.0),
                            ),
                            onPressed: onSubmit,
                            child: Text(
                              "Submit",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildSurveyQuestions() {
    return questions.map((questionRef) {
      final question = questionMap[questionRef.code];
      if (question == null) {
        return const SizedBox.shrink();
      }

      return _buildQuestionWidget(question);
    }).toList();
  }

  Widget _buildQuestionWidget(Question question) {
    switch (question.component) {
      case "InputNPS":
        return InputNPS(
          onRatingSelected: (int rating) {
            onAnswerUpdate(question.code, rating); // Store the selected rating
          },
        );
      case "InputStar":
        return InputStar(
          text: question.label,
          onStarSelected: (int rating) {
            onAnswerUpdate(question.code, rating); // Store the selected star rating
          },
        );
      case "InputText":
        return InputText(
          label: question.label,
          onTextChanged: (String text) {
            onAnswerUpdate(question.code, text); // Store the entered text
          },
        );
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            question.label,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202020),
              ),
            ),
          ),
        );
    }
  }
}
