// lib/helpers/question_service.dart

const String sampleSurveyData = '''
{
  "question_set": "NPS",
  "question_sets": [
    {
      "name": "NPS",
      "title": "Share your feedback",
      "questions": [
        {"order": 1, "code": "NET_PROMOTER_SCORE"},
        {"order": 2, "code": "SECTION_HEADER"},
        {"order": 3, "code": "CSAT_1"},
        {"order": 4, "code": "CSAT_2"},
        {"order": 5, "code": "CSAT_3"},
        {"order": 6, "code": "CSAT_4"},
        {"order": 7, "code": "COMMENT"}
      ],
      "submit_button": {"label": "Submit"}
    }
  ],
  "questions": [
    {
      "type": "InputNPS",
      "code": "NET_PROMOTER_SCORE",
      "label": "On a scale of 1 to 10, how likely are you to recommend our service to others?",
      "component": "InputNPS"
    },
    {
      "type": "SectionHeader",
      "code": "SECTION_HEADER",
      "label": "Rate our services in the following areas:"
    },
    {
      "type": "InputStar",
      "code": "CSAT_1",
      "label": "Clear information and instructions",
      "component": "InputStar"
    },
    {
      "type": "InputStar",
      "code": "CSAT_2",
      "label": "User-friendly navigation",
      "component": "InputStar"
    },
    {
      "type": "InputStar",
      "code": "CSAT_3",
      "label": "Easy to complete transaction",
      "component": "InputStar"
    },
    {
      "type": "InputStar",
      "code": "CSAT_4",
      "label": "Engaging design and visuals",
      "component": "InputStar"
    },
    {
      "type": "InputText",
      "code": "COMMENT",
      "label": "Are there any areas you think PRUServices can improve on?",
      "component": "InputText"
    }
  ],
  "question_types": [
    {"type": "InputNPS", "description": "A numerical rating scale from 1 to 10."},
    {"type": "InputStar", "description": "A numerical rating scale from 1 to 5."},
    {"type": "SectionHeader", "description": "A section header for grouping related questions."},
    {"type": "InputText", "description": "A free text input field for comments."}
  ]
}
''';
