import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  // Method to determine which SVG to load based on index and active state
  String _getSvgPath(int index, bool isActive) {
    if (index <= 5) {
      return isActive
          ? 'packages/flutter_cx_nps_survey/lib/assets/nps_low_active.svg'
          : 'packages/flutter_cx_nps_survey/lib/assets/nps_low.svg';
    } else if (index <= 7) {
      return isActive
          ? 'packages/flutter_cx_nps_survey/lib/assets/nps_med_active.svg'
          : 'packages/flutter_cx_nps_survey/lib/assets/nps_med.svg';
    } else {
      return isActive
          ? 'packages/flutter_cx_nps_survey/lib/assets/nps_high_active.svg'
          : 'packages/flutter_cx_nps_survey/lib/assets/nps_high.svg';
    }
  }

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
              color: Colors.grey[600] ?? Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(10, (index) {
            int number = index + 1;
            bool isActive = _selectedIndex >= index;

            Color buttonTextColor = isActive ? Colors.black : Colors.grey[600] ?? Colors.grey;
            Color buttonColor = Colors.transparent;
            Color borderColor = const Color(0xFFDCDCDC);
            FontWeight fontWeight = isActive ? FontWeight.bold : FontWeight.normal;

            // Custom border radius based on first, middle, last button
            BorderRadius borderRadius;
            if (index == 0) {
              borderRadius = const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              );
            } else if (index == 9) {
              borderRadius = const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              );
            } else {
              borderRadius = BorderRadius.zero;
            }

            // Border properties, no right border unless index is 9
            BorderSide rightBorder = index == 9
                ? BorderSide(color: borderColor, width: 1)
                : BorderSide.none;

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
                    // Add the smiley SVG icons above the buttons
                    SvgPicture.asset(
                      _getSvgPath(index, isActive),
                      height: 20.0, // Adjust SVG size as necessary
                    ),
                    const SizedBox(height: 16.0), // 16px space between smiley and button
                    // Buttons for selecting NPS value
                    Container(
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: buttonColor, // Button will be filled up to the selected index
                        borderRadius: borderRadius,
                        border: Border(
                          top: BorderSide(color: borderColor, width: 1),
                          left: BorderSide(color: borderColor, width: 1),
                          bottom: BorderSide(color: borderColor, width: 1),
                          right: rightBorder,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$number',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: buttonTextColor,
                              fontWeight: fontWeight,
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
