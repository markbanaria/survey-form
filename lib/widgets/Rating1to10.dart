import 'package:flutter/material.dart';

class _Icon1to10 extends StatefulWidget {
  @override
  _Icon1to10State createState() => _Icon1to10State();
}

class _Icon1to10State extends State<_Icon1to10> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(10, (index) {
          int number = index + 1;
          IconData iconData = number <= 5 ? Icons.sentiment_dissatisfied : Icons.sentiment_satisfied;
          Color iconColor;
          Color buttonColor;
          Color buttonTextColor = _selectedIndex == index ? Colors.white : Color(0xFF727272);
          Color borderColor;

          if (number <= 4) {
            iconColor = _selectedIndex == index ? Colors.red : Color(0xFFDCDCDC);
            buttonColor = _selectedIndex == index ? Colors.red : Colors.transparent;
            borderColor = _selectedIndex == index ? Colors.red : Color(0xFFDCDCDC);
          } else if (number <= 7) {
            iconColor = _selectedIndex == index ? Color(0xFFE79547) : Color(0xFFDCDCDC);
            buttonColor = _selectedIndex == index ? Color(0xFFE79547) : Colors.transparent;
            borderColor = _selectedIndex == index ? Color(0xFFE79547) : Color(0xFFDCDCDC);
          } else {
            iconColor = _selectedIndex == index ? Colors.green : Color(0xFFDCDCDC);
            buttonColor = _selectedIndex == index ? Colors.green : Colors.transparent;
            borderColor = _selectedIndex == index ? Colors.green : Color(0xFFDCDCDC);
          }

          return Expanded( // Make each column expand to fill the Row evenly
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min, // Minimize height to content
                children: [
                  Icon(iconData, color: iconColor),
                  SizedBox(height: 4.0), // Spacing between icon and button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add 4px padding on both sides
                    child: Container(
                      height: 40.0, // Provide a fixed height to the container
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: borderColor, width: _selectedIndex == index ? 2 : 1), // Border color and width
                      ),
                      child: Center(
                        child: Text(
                          '$number',
                          style: TextStyle(
                            color: buttonTextColor,
                            fontWeight: FontWeight.w700, // Set weight to 700
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
    );
  }
}