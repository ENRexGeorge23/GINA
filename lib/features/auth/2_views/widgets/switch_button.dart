import 'package:flutter/material.dart';

Container switchButton(double screenWidth, int selectedIndex) {
  return Container(
    width: 250,
    height: 38,
    decoration: BoxDecoration(
      color: const Color(0xFFF3F3F3),
      borderRadius: BorderRadius.circular(23),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            selectedIndex = 0;
          },
          child: buildPositionedOption(
            'Patient',
            38,
            isSelected: selectedIndex == 0,
            screenWidth: screenWidth,
          ),
        ),
        const SizedBox(width: 0),
        GestureDetector(
          onTap: () {
            selectedIndex = 1;
          },
          child: buildPositionedOption(
            'Doctor',
            38,
            isSelected: selectedIndex == 1,
            screenWidth: screenWidth,
          ),
        ),
      ],
    ),
  );
}

AnimatedContainer buildPositionedOption(String label, double height,
    {required bool isSelected, required double screenWidth}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: 125,
    height: height,
    decoration: ShapeDecoration(
      color: isSelected ? const Color(0xFFFFC0CB) : const Color(0xFFF3F3F3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF36344E) : const Color(0xFF9493A0),
          fontSize: 12,
          fontFamily: 'SF UI Display',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
