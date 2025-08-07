import 'package:first_app/core/resources/images.dart';
import 'package:flutter/material.dart';

class DoctorEmergencyAnnouncementInitialScreen extends StatelessWidget {
  const DoctorEmergencyAnnouncementInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            Images.doctorEmergencyAnnouncementInitial,
            width: 850,
            filterQuality: FilterQuality.high,
          ),
        )
      ],
    );
  }
}
