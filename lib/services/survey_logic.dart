import 'dart:math';

class SurveyLogic {
  final String customerId;

  SurveyLogic({required this.customerId});

  // Simulate an async API call
  Future<bool> shouldShowSurvey() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    final randomValue = Random().nextInt(100); // Random value between 0-99
    return randomValue % 2 == 0; // Show survey if even, hide if odd
  }
}
