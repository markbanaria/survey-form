import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/submission_config.dart'; // Import the SubmissionConfig class

class SubmissionManager {
  final Map<String, dynamic> surveyResponses = {};

  void collectResponse(String question, dynamic response) {
    surveyResponses[question] = response;
  }

  String generateSubmissionObject() {
    return jsonEncode(surveyResponses);
  }

  Future<void> submitSurvey(SubmissionConfig config) async {
    final body = config.bodyBuilder(surveyResponses); // Get raw map data
    final response;

    // Trigger the onSubmit callback if provided
    if (config.onSubmit != null) {
      config.onSubmit!();
    }

    try {
      switch (config.type) {
        case SubmissionType.http:
          response = await http.post(
            Uri.parse(config.url),
            headers: config.headers,
            body: jsonEncode(body), // Now encode to JSON here
          );
          if (response.statusCode == 200) {
            // Trigger the onSuccess callback if provided
            if (config.onSuccess != null) {
              config.onSuccess!();
            }
          } else {
            // Trigger the onError callback if provided
            if (config.onError != null) {
              config.onError!('Failed to submit survey via HTTP. Status code: ${response.statusCode}');
            }
          }
          break;

        case SubmissionType.graph:
          // Using graphql_flutter for GraphQL requests
          final HttpLink httpLink = HttpLink(config.url);

          final GraphQLClient client = GraphQLClient(
            link: httpLink,
            cache: GraphQLCache(),
          );

          final MutationOptions options = MutationOptions(
            document: gql(body['query']), // Extract query and variables as required
            variables: body['variables'],
          );

          final result = await client.mutate(options);

          if (result.hasException) {
            // Trigger the onError callback if provided
            if (config.onError != null) {
              config.onError!('GraphQL submission failed: ${result.exception.toString()}');
            }
          } else {
            // Trigger the onSuccess callback if provided
            if (config.onSuccess != null) {
              config.onSuccess!();
            }
          }
          break;
      }
    } catch (e) {
      // Trigger the onError callback if provided
      if (config.onError != null) {
        config.onError!(e.toString());
      }
    }
  }
}
