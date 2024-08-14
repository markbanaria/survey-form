// lib/widgets/radio_buttons_widget.dart
import 'package:flutter/material.dart';

class RadioButtonsWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final ValueChanged<String?> onSelected;

  RadioButtonsWidget({
    required this.question,
    required this.options,
    required this.onSelected,
  });

  @override
  _RadioButtonsWidgetState createState() => _RadioButtonsWidgetState();
}

class _RadioButtonsWidgetState extends State<RadioButtonsWidget> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.question),
        Column(
          children: widget.options.map((option) {
            return RadioListTile(
              title: Text(option),
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
                widget.onSelected(_selectedOption);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
