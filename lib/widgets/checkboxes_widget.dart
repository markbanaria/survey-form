// lib/widgets/checkboxes_widget.dart
import 'package:flutter/material.dart';

class CheckboxesWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final ValueChanged<List<String>> onSelectionChanged;

  CheckboxesWidget({
    required this.question,
    required this.options,
    required this.onSelectionChanged,
  });

  @override
  _CheckboxesWidgetState createState() => _CheckboxesWidgetState();
}

class _CheckboxesWidgetState extends State<CheckboxesWidget> {
  List<String> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.question),
        Column(
          children: widget.options.map((option) {
            return CheckboxListTile(
              title: Text(option),
              value: _selectedOptions.contains(option),
              onChanged: (isSelected) {
                setState(() {
                  if (isSelected == true) {
                    _selectedOptions.add(option);
                  } else {
                    _selectedOptions.remove(option);
                  }
                });
                widget.onSelectionChanged(_selectedOptions);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
