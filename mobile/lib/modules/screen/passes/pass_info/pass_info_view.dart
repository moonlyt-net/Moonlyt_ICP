import 'package:flutter/material.dart';

class PassInfoView extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Function(int) onTap;

  PassInfoView({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  List<String> menu = [
    'Preview',
    'Benefits',
    'Missions',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          '${menu[index]}',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.75),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
