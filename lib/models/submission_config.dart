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
SubmissionConfig<Map<String, dynamic>> jsonSubmissionConfig({
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
    bodyBuilder: (data) => data, // Pass the map data directly, no jsonEncode here
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
    bodyBuilder: (data) => data, // Pass data as-is
    onSubmit: onSubmit,
    onSuccess: onSuccess,
    onError: onError,
  );
}
