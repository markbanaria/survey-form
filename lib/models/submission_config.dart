import 'callback_types.dart'; // Import the callback types

enum SubmissionType {
  http,
  graph,
}

class SubmissionConfig {
  final SubmissionType type;
  final String url;
  final Map<String, String> headers;
  final Map<String, dynamic> Function(Map<String, dynamic> data) bodyBuilder;

  final SubmissionCallback? onSubmit;
  final SuccessCallback? onSuccess;
  final ErrorCallback? onError;

  SubmissionConfig({
    required this.type,
    required this.url,
    required this.headers,
    required this.bodyBuilder,
    this.onSubmit,
    this.onSuccess,
    this.onError,
  });
}
