// lib/widgets/text_field_widget.dart
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String question;
  final TextEditingController controller;

  TextFieldWidget({
    required this.question,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: question,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
