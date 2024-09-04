class AnswersService {
  Map<String, dynamic> generateSurveyResponses(String customerId, Map<String, dynamic> responses) {
    return {
      'customerId': customerId,
      'answers': responses.entries.map((entry) {
        return {
          'code': entry.key,
          'answer': entry.value,
        };
      }).toList(),
    };
  }
}