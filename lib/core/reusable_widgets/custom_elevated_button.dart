import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your sign-up logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFC0CB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.45,
        height: 49,
        child: const Center(
          child: Text(
            'Next',
            style: TextStyle(
              color: Color(0xFF36344E),
              fontSize: 16,
              fontFamily: 'SF UI Display',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
