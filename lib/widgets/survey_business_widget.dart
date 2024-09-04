import 'package:flutter/material.dart';
import '../models/survey_config.dart';
import '../services/api_service.dart';
import '../services/answers_service.dart';
import 'survey_ui.dart';

class SurveyBusinessWidget extends StatefulWidget {
  const SurveyBusinessWidget({
    super.key,
    required this.surveyQuestionSet,
    required this.customerId,
  });

  final String surveyQuestionSet;
  final String customerId;

  @override
  State<SurveyBusinessWidget> createState() => _SurveyBusinessWidgetState();

  static void showSurveyDialog({
    required BuildContext context,
    required String surveyQuestionSet,
    required String customerId,
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    final bool shouldShow = await checkShouldShowSurvey(customerId);

    if (shouldShow) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _SlideInDialog(
            surveyQuestionSet: surveyQuestionSet,
            customerId: customerId,
            duration: duration,
          );
        },
      );
    } else {
      print('Survey will not be shown based on the API logic.');
    }
  }
}

class _SlideInDialog extends StatefulWidget {
  final String surveyQuestionSet;
  final String customerId;
  final Duration duration;

  const _SlideInDialog({
    required this.surveyQuestionSet,
    required this.customerId,
    required this.duration,
  });

  @override
  _SlideInDialogState createState() => _SlideInDialogState();
}

class _SlideInDialogState extends State<_SlideInDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Align(
        alignment: Alignment.topRight,
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 1.0,
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            child: SurveyBusinessWidget(
              surveyQuestionSet: widget.surveyQuestionSet,
              customerId: widget.customerId,
            ),
          ),
        ),
      ),
    );
  }
}

class _SurveyBusinessWidgetState extends State<SurveyBusinessWidget> {
  late List<QuestionReference> _questions = [];
  late Map<String, Question> _questionMap = {};
  late final Map<String, dynamic> _responses = {};
  late String _title = "";
  bool _isLoading = true; // Track loading state
  bool _isSubmitting = false; // Track submission state
  final AnswersService _answersService = AnswersService();


  @override
  void initState() {
    super.initState();
    _loadSurveyData();
  }

  Future<void> _loadSurveyData() async {
    try {
      final surveyData = await loadSurveyData(widget.surveyQuestionSet);
      setState(() {
        _questions = (surveyData["selectedSet"]["questions"] as List<dynamic>)
            .map((q) => QuestionReference.fromJson(q))
            .toList();
        _questionMap = _mapQuestions((surveyData["questions"] as List<dynamic>)
            .map((q) => Question.fromJson(q))
            .toList());
        _title = surveyData["selectedSet"]["title"];
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load survey data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Map<String, Question> _mapQuestions(List<Question> questions) {
    return {
      for (var question in questions) question.code: question,
    };
  }

  void _submitSurvey() async {
    setState(() {
      _isSubmitting = true;
    });

    Map<String, dynamic> surveyResponses = _answersService.generateSurveyResponses(widget.customerId, _responses);


    await submitSurvey(
      surveyResponses,
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Survey submitted successfully.')),
        );
        setState(() {
          _isSubmitting = false;
        });
        Navigator.of(context).pop();
      },
      (int statusCode) {
        print('Failed to submit survey: $statusCode');
        setState(() {
          _isSubmitting = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SurveyUI(
      isLoading: _isLoading,
      title: _title,
      questions: _questions,
      questionMap: _questionMap,
      isSubmitting: _isSubmitting,
      onSubmit: _submitSurvey,
      onAnswerUpdate: (code, answer) {
        setState(() {
          _responses[code] = answer;
        });
      },
    );
  }
}
