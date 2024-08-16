import 'dart:convert'; // Import this to use jsonEncode and jsonDecode
import 'callback_types.dart'; // Import the callback types

enum SubmissionType {
  http,
  graph,
}

class SubmissionConfig<T> {
  final SubmissionType type;
  final String url;
  final Map<String, String> headers;
  final T Function(Map<String, dynamic> data) bodyBuilder;

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

// Helper functions for common use cases
SubmissionConfig<String> jsonSubmissionConfig({
  required String url,
  required Map<String, String> headers,
  required SubmissionCallback? onSubmit,
  required SuccessCallback? onSuccess,
  required ErrorCallback? onError,
}) {
  return SubmissionConfig<String>(
    type: SubmissionType.http,
    url: url,
    headers: headers,
    bodyBuilder: (data) => jsonEncode(data),
    onSubmit: onSubmit,
    onSuccess: onSuccess,
    onError: onError,
  );
}

SubmissionConfig<Map<String, dynamic>> mapSubmissionConfig({
  required String url,
  required Map<String, String> headers,
  required SubmissionCallback? onSubmit,
  required SuccessCallback? onSuccess,
  required ErrorCallback? onError,
}) {
  return SubmissionConfig<Map<String, dynamic>>(
    type: SubmissionType.http,
    url: url,
    headers: headers,
    bodyBuilder: (data) => data,
    onSubmit: onSubmit,
    onSuccess: onSuccess,
    onError: onError,
  );
}
