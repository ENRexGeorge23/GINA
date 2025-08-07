import 'package:flutter/material.dart';

AnimatedContainer tabController(
    {required bool isSelected, required String label, required double height}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: 110,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 110,
      height: height,
      decoration: ShapeDecoration(
        color: isSelected ? const Color(0xFFFFC0CB) : const Color(0xFFE6E6E6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color:
                isSelected ? const Color(0xFF36344E) : const Color(0xFF9493A0),
            fontSize: 13,
            fontFamily: 'SF UI Display',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
