// lib/widgets/slider_widget.dart
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final String question;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  SliderWidget({
    required this.question,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _currentValue;

  _SliderWidgetState() : _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.question),
        Slider(
          value: _currentValue,
          min: widget.min,
          max: widget.max,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
            widget.onChanged(value);
          },
        ),
        Text('Value: ${_currentValue.toStringAsFixed(1)}'),
      ],
    );
  }
}
