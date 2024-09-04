import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputNPS extends StatefulWidget {
  final Function(int) onRatingSelected; // Callback to parent

  const InputNPS({super.key, required this.onRatingSelected});

  @override
  _InputNPSState createState() => _InputNPSState();
}

class _InputNPSState extends State<InputNPS> {
  int _selectedIndex = -1;
  final String label =
      "Based on today's experience with PruServices, how likely would you recommend Prudential to your family and friends?";
  final String minlabel = "Not likely at all";
  final String maxlabel = "Extremely Likely";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600] ?? Colors.grey, // Removed 'const' to allow non-constant color
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(10, (index) {
            int number = index + 1;
            IconData iconData =
                number <= 5 ? Icons.sentiment_dissatisfied : Icons.sentiment_satisfied;
            Color iconColor;
            Color buttonColor;
            Color buttonTextColor = _selectedIndex == index
                ? Colors.white
                : Colors.grey[600] ?? Colors.grey;
            Color borderColor;

            if (number <= 4) {
              iconColor = _selectedIndex == index ? Colors.red : const Color(0xFFDCDCDC);
              buttonColor = _selectedIndex == index ? Colors.red : Colors.transparent;
              borderColor = _selectedIndex == index ? Colors.red : const Color(0xFFDCDCDC);
            } else if (number <= 7) {
              iconColor = _selectedIndex == index ? const Color(0xFFE79547) : const Color(0xFFDCDCDC);
              buttonColor = _selectedIndex == index ? const Color(0xFFE79547) : Colors.transparent;
              borderColor = _selectedIndex == index ? const Color(0xFFE79547) : const Color(0xFFDCDCDC);
            } else {
              iconColor = _selectedIndex == index ? Colors.green : const Color(0xFFDCDCDC);
              buttonColor = _selectedIndex == index ? Colors.green : Colors.transparent;
              borderColor = _selectedIndex == index ? Colors.green : const Color(0xFFDCDCDC);
            }

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onRatingSelected(number); // Notify parent of selected value
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(iconData, color: iconColor),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                              color: borderColor, width: _selectedIndex == index ? 2 : 1),
                        ),
                        child: Center(
                          child: Text(
                            '$number',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: buttonTextColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Text(
              minlabel,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[500],
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Text(
              maxlabel,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
