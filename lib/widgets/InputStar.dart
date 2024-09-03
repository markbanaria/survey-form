import 'package:flutter/material.dart';

class InputStar extends StatefulWidget {
  final String text; // The text to be displayed on the left

  InputStar({required this.text});

  @override
  _InputStarState createState() => _InputStarState();
}

class _InputStarState extends State<InputStar> {
  int _rating = 0; // Initial rating set to 0 (unfilled stars)

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Row(
          children: [
            Text(
              widget.text, // Display the passed text
              style: const TextStyle(
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
                return Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        color: index < _rating ? const Color(0xFFE79547) : const Color(0xFFDCDCDC),
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = index + 1; // Update the rating based on the star clicked
                        });
                      },
                      iconSize: 20.0, // Smaller size for the star icons
                      padding: EdgeInsets.zero, // Remove padding between icons
                      constraints: const BoxConstraints(), // Remove default constraints for more control
                    ),
                    if (index < 4) const SizedBox(width: 4.0), // Add 4px spacing between stars
                  ],
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
