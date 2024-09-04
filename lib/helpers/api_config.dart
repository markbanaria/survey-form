// API Base URL
const String BASE_URL = 'https://pas-rust.vercel.app/api/public/customers';

// API Endpoints
const String SHOW_SURVEY_URL = '$BASE_URL/survey';
const String SUBMIT_SURVEY_URL = '$BASE_URL/postfeedbackresponse';

// Common headers
const Map<String, String> HEADERS = {
  'Content-Type': 'application/json',
};
