import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; 

//local
import '../services/survey_logic.dart';
import '../models/survey_config.dart';
import 'InputNPS.dart';
import 'InputStar.dart';

class SurveyForm extends StatefulWidget {
  const SurveyForm({
    super.key,
    required this.surveyQuestionSet,
    required this.customer,
    required this.showAPI,
    required this.submitAPI,
  });

  final String surveyQuestionSet;
  final String customer;
  final String showAPI;
  final String submitAPI;

  @override
  State<SurveyForm> createState() => _SurveyFormState();

  // Method to show the dialog if the API call determines it's needed
  static void showSurveyDialog(BuildContext context, String surveyQuestionSet, String customer, String showAPI, String submitAPI) async {
    final bool shouldShow = await _SurveyFormState()._checkShouldShowSurvey(showAPI, customer);

    if (shouldShow) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.topRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,  // Occupy half of the screen horizontally
              heightFactor: 1.0, // Occupy full screen vertically
              child: Dialog(
                insetPadding: EdgeInsets.zero, // Remove default padding
                child: SurveyForm(
                  surveyQuestionSet: surveyQuestionSet,
                  customer: customer,
                  showAPI: showAPI,
                  submitAPI: submitAPI,
                ),
              ),
            ),
          );
        },
      );
    } else {
      print('Survey will not be shown based on the API logic.');
    }
  }
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
    return Material(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.surveyQuestionSet,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 40.0),
            Expanded(child: ListView(children: _buildSurveyQuestions())),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                ),
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
                onPressed: () {
                  // Collect survey responses from form components
                  Map<String, dynamic> surveyResponses = {
                    // Populate with actual survey data
                  };
                  _submitSurvey(widget.submitAPI, surveyResponses);
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
          ],
        ),
      ),
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
      case "InputNPS":
        return InputNPS(); // Replace with your actual widget
      case "InputStar":
        return InputStar(text: question.label);
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
 

 
  Future<void> _submitSurvey(String submitAPI, Map<String, dynamic> surveyResponses) async {
    bool isTesting = true; // Set this to false to use the actual API call

    if (isTesting) {
      // Show a success snackbar here for testing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Survey submitted successfully (testing mode).'),
        ),
      );
      return;
    }
    
    // Load API credentials from api.json and find submitAPI
    String apiData = await DefaultAssetBundle.of(context).loadString("assets/api.json");
    final apiCredentials = json.decode(apiData);

    final apiInfo = apiCredentials["apis"][submitAPI];

    if (apiInfo == null) {
      print('API not found');
      return;
    }

    final url = apiInfo["url"];
    final apiKey = apiInfo["apiKey"];

    // Perform the API request
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode(surveyResponses),
    );

    if (response.statusCode == 200) {
      // Show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Survey submitted successfully.'),
        ),
      );
    } else {
      print('Failed to submit survey: ${response.statusCode}');
    }
  }

  Future<bool> _checkShouldShowSurvey(String showAPI, String customerId) async {
    bool isTesting = true; // Set this to false to use the actual API call

    if (isTesting) {
      int customerNumber = int.tryParse(customerId) ?? 0;
      return customerNumber % 2 == 0; // Returns true if even, false if odd
    }

    // Load API credentials from api.json and find showAPI
    String apiData = await DefaultAssetBundle.of(context).loadString("assets/api.json");
    final apiCredentials = json.decode(apiData);

    final apiInfo = apiCredentials["apis"][showAPI];

    if (apiInfo == null) {
      print('API not found');
      return false;
    }

    final url = apiInfo["url"];
    final apiKey = apiInfo["apiKey"];

    // Perform the API request
    final response = await http.get(
      Uri.parse('$url?customerId=$customerId'),
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['show_survey'] == true; // Adjust based on your API response format
    } else {
      print('Failed to load survey check');
      return false;
    }
  }
}
