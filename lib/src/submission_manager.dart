import 'dart:convert'; // Import for JSON encoding
import 'package:http/http.dart' as http;

enum SubmissionType {
  http,
  graph,
}

class SubmissionConfig {
  final SubmissionType type;
  final String url;
  final Map<String, String> headers;
  final Map<String, dynamic> Function(Map<String, dynamic> data) bodyBuilder;

  SubmissionConfig({
    required this.type,
    required this.url,
    required this.headers,
    required this.bodyBuilder,
  });
}

class SubmissionManager {
  final Map<String, dynamic> surveyResponses = {};

  void collectResponse(String question, dynamic response) {
    surveyResponses[question] = response;
  }

  String generateSubmissionObject() {
    return jsonEncode(surveyResponses); // Use jsonEncode to convert Map to JSON string
  }

  Future<void> submitSurvey(SubmissionConfig config) async {
    final body = config.bodyBuilder(surveyResponses);
    final response;

    switch (config.type) {
      case SubmissionType.http:
        response = await http.post(
          Uri.parse(config.url),
          headers: config.headers,
          body: jsonEncode(body),
        );
        break;

      case SubmissionType.graph:
        response = await http.post(
          Uri.parse(config.url),
          headers: config.headers,
          body: jsonEncode({
            'query': body['query'],
            'variables': body['variables'],
          }),
        );
        break;
    }

    if (response.statusCode == 200) {
      print('Survey submitted successfully!');
    } else {
      print('Failed to submit survey. Status code: ${response.statusCode}');
    }
  }
}
