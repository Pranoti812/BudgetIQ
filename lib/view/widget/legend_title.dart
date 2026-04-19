import 'package:flutter/material.dart';

class LegendTile extends StatelessWidget {
  final Color color;
  final String text;

  const LegendTile({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 10, width: 10, color: color),
        const SizedBox(width: 6),
        Expanded(child: Text(text)),
      ],
    );
  }
}