// lib/helpers/api_helpers.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/api_config.dart';
import 'questions_service.dart';

Future<bool> checkShouldShowSurvey(String customerId) async {
  final response = await http.post(
    Uri.parse(SHOW_SURVEY_URL), // Use constant for survey URL
    headers: HEADERS, // Use constant for headers
    body: json.encode({"customerId": customerId}),
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse['showsurvey'] == true; // Adjust based on your API response format
  } else {
    print('Failed to load survey check');
    return false;
  }
}

Future<void> submitSurvey(Map<String, dynamic> surveyResponses, Function onSuccess, Function onError) async {
  final response = await http.post(
    Uri.parse(SUBMIT_SURVEY_URL), // Use constant for submit survey URL
    headers: HEADERS, // Use constant for headers
    body: json.encode(surveyResponses),
  );

  if (response.statusCode == 200) {
    onSuccess();
  } else {
    onError(response.statusCode);
  }
}

Future<Map<String, dynamic>> loadSurveyData(String surveyQuestionSet) async {
  // Load the JSON data from the externalized file
  final jsonData = json.decode(sampleSurveyData); // Use the imported sample data

  // Simulating the selection of a specific question set
  final selectedSet = (jsonData["question_sets"] as List<dynamic>)
      .firstWhere((set) => set["name"] == surveyQuestionSet, orElse: () => null);

  if (selectedSet != null) {
    return {
      "selectedSet": selectedSet,
      "questions": jsonData["questions"],
    };
  } else {
    throw Exception("Survey question set not found");
  }
}
