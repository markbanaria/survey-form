import 'package:flutter/material.dart';

class StarRatingRow extends StatefulWidget {
  final String text; // The text to be displayed on the left

  StarRatingRow({required this.text});

  @override
  _StarRatingRowState createState() => _StarRatingRowState();
}

class _StarRatingRowState extends State<StarRatingRow> {
  int _rating = 0; // Initial rating set to 0 (unfilled stars)

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.text, // Display the passed text
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF202020),
          ),
        ),
        Expanded(
          child: SizedBox(), // To push the stars to the right
        ),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: index < _rating ? Color(0xFFE79547) : Color(0xFFA0A0A0),
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1; // Update the rating based on the star clicked
                });
              },
              iconSize: 24.0, // Size of the star icons
              padding: EdgeInsets.zero, // Remove padding between icons
              constraints: BoxConstraints(), // Remove default constraints for more control
            );
          }),
        ),
      ],
    );
  }
}