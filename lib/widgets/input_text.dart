import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputText extends StatefulWidget {
  final String label; // The label to be displayed above the text input
  final Function(String) onTextChanged; // Callback to parent

  InputText({required this.label, required this.onTextChanged});

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  TextEditingController _controller = TextEditingController(); // Controller to manage the text input

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start of the column
      children: [
        const SizedBox(height: 16.0),
        Container(
          height: 1,
          color: Color(0xFFDCDCDC),
        ),
        const SizedBox(height: 24.0),
        Text(
          widget.label, // Display the passed label
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF757575), // Gray 600 color
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: _controller,
          onChanged: (value) {
            widget.onTextChanged(value); // Notify parent of text change
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          ),
          minLines: 3, // Minimum number of lines for the text area
          maxLines: null, // No maximum number of lines (allows expansion)
          keyboardType: TextInputType.multiline, // Set keyboard type to multiline
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
