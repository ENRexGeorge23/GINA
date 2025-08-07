import 'package:flutter/material.dart';

class GinaDoctorHeader extends StatelessWidget {
  final double size;
  const GinaDoctorHeader({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF36344E)),
            borderRadius:
                BorderRadius.circular(5), // Adjust the border radius as needed
          ),
          margin: const EdgeInsets.fromLTRB(65, 9, 0, 0),
          child: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 6, vertical: 1), // Adjust padding as needed
            child: Text(
              'DR.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF36344E), // Text color inside the box
                fontSize: 15,
                fontFamily: 'Cormorant Upright',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5), // Adjust spacing between "DR." and "GINA"
        Text(
          'GINA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF36344E),
            fontSize: size,
            fontFamily: 'Cormorant Upright',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
