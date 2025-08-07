import 'package:first_app/core/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ConsultationNoAppointmentScreen extends StatelessWidget {
  const ConsultationNoAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset(Images.consultationNoAppointment)),
        const Gap(150),
      ],
    );
  }
}
