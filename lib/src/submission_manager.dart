import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';

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
    return jsonEncode(surveyResponses);
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
        if (response.statusCode == 200) {
          print('HTTP survey submitted successfully!');
        } else {
          print('Failed to submit survey via HTTP. Status code: ${response.statusCode}');
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
          document: gql(body['query']),
          variables: body['variables'],
        );

        final result = await client.mutate(options);

        if (result.hasException) {
          print('GraphQL submission failed: ${result.exception.toString()}');
        } else {
          print('GraphQL survey submitted successfully!');
        }
        break;
    }
  }
}
