// lib/widgets/star_rating_widget.dart
import 'package:flutter/material.dart';

class StarRatingWidget extends StatefulWidget {
  final String question;
  final int maxRating;
  final ValueChanged<int> onRatingSelected;

  StarRatingWidget({
    required this.question,
    required this.maxRating,
    required this.onRatingSelected,
  });

  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.question),
        Row(
          children: List.generate(widget.maxRating, (index) {
            return IconButton(
              icon: Icon(
                index < _currentRating ? Icons.star : Icons.star_border,
              ),
              onPressed: () {
                setState(() {
                  _currentRating = index + 1;
                });
                widget.onRatingSelected(_currentRating);
              },
            );
          }),
        ),
      ],
    );
  }
}
